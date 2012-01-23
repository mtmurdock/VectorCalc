//
//  MMMainViewController.m
//  VectorCalc
//
//  Created by Matthew Murdock on 1/18/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MMMainViewController.h"
#import "MMExtensions.h"
#import "MMVector.h"
#import "MMVectorCell.h"
#import "MMCreateOrEditVectorViewController.h"

#define kStdButtonHeight	       40.0
#define kPadding                   5.0
#define kButtonSheetVisibleOffset  114.0
#define kButtonSheetHiddenOffset   64.0
#define kButtonSheetHeight         50.0

@implementation MMMainViewController
@synthesize vectors = _vectors, tableView = _tableView;

# pragma mark init

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        _vectors = [[NSMutableArray array] retain];
        
        //test code:
        [_vectors addObject:[[MMVector alloc] initWithX:0.0f Y:0.0f Z:0.0f]];
        [_vectors addObject:[[MMVector alloc] initWithX:0.0f Y:0.0f Z:0.0f]];
    }
    return self;
}

- (void) viewDidLoad
{
    // set up navigation bar
    self.navigationItem.title = @"Vectors";
    UIBarButtonItem* newVectorButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addAction:)];
    self.navigationItem.rightBarButtonItem = newVectorButton;
    
    // set up table view
    _tableView = [UITableView tableViewForViewController:self];
    
    // set up edit butons sheet
    CGRect windowRect = [[UIScreen mainScreen] bounds];
    _buttonSheet = [[UIView alloc] init];
    _editButton = [[UIButton buttonWithType:UIButtonTypeRoundedRect] retain];
    _deleteButton = [[UIButton buttonWithType:UIButtonTypeRoundedRect] retain];
    
    // add callbacks
    [_editButton addTarget:self action:@selector(editAction:) forControlEvents:UIControlEventTouchUpInside];
    [_deleteButton addTarget:self  action:@selector(deleteAction:) forControlEvents:UIControlEventTouchUpInside];
    
    // set look-and-feel stuff
    [_editButton setTitle:@"Edit" forState:UIControlStateNormal];
    [_deleteButton setTitle:@"Delete" forState:UIControlStateNormal];
    _buttonSheet.backgroundColor = [UIColor whiteColor];
    
    // calculate frames
    _buttonSheet.frame = CGRectMake(0, windowRect.size.height - kButtonSheetHiddenOffset, windowRect.size.width, kButtonSheetHeight);
    _editButton.frame = CGRectInset(CGRectMake(0, 0, _buttonSheet.frame.size.width / 2, kStdButtonHeight + 2*kPadding), kPadding, kPadding);
    _deleteButton.frame = CGRectInset(CGRectMake(_buttonSheet.frame.size.width / 2, 0, _buttonSheet.frame.size.width / 2, kStdButtonHeight + 2*kPadding), kPadding, kPadding);
    
    // add views
    [_buttonSheet addSubview:_editButton];
    [_buttonSheet addSubview:_deleteButton];
    [self.view addSubview:_buttonSheet];
    [self.view addSubview:_tableView];
    [self.view bringSubviewToFront:_buttonSheet];
}

- (void) viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [_tableView reloadData];
    [self hideButtonSheet];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return YES;
}

#pragma mark UITableViewDelegate/DataSource

- (UITableViewCell*) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MMVectorCell* cell = [tableView dequeueReusableCellWithIdentifier:@"vector"];
    if(!cell) {
        cell = [[MMVectorCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"vector"];
        [cell setFrame:CGRectMake(0, 0, self.view.bounds.size.width, 50)];
    }
    
    [cell setVector:[_vectors objectAtIndex:indexPath.row]];
    
    return cell;
}

- (void) tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    // set cell color
    [cell setBackgroundColor:[UIColor whiteColor]];
}

static NSIndexPath* prevPath = nil;
- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([prevPath isEqual:indexPath])
    {
        [tableView deselectRowAtIndexPath:indexPath animated:true];
        prevPath = nil;
        
        [self hideButtonSheet];
    }
    else
    {
        [tableView selectRowAtIndexPath:indexPath animated:true scrollPosition:UITableViewScrollPositionNone];
        prevPath = [indexPath copy];
        
        [self showButtonSheet];
    }
}

- (int) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _vectors.count;
}

- (float) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}

# pragma mark - GUI Callbacks

- (void)addAction:(id)sender
{
    MMCreateOrEditVectorViewController* vc = [[MMCreateOrEditVectorViewController alloc] init];
    vc.parent = self;
    [self.navigationController pushViewController:vc animated:true];
}

- (void)editAction:(id)sender
{
    MMVector* vector = [_vectors objectAtIndex:[_tableView indexPathForSelectedRow].row];
    MMCreateOrEditVectorViewController* vc = [[MMCreateOrEditVectorViewController alloc] init];
    vc.vector = vector;
    vc.parent = self;
    [self.navigationController pushViewController:vc animated:true];
    
}

- (void)deleteAction:(id)sender
{
    [_vectors removeObjectAtIndex:[_tableView indexPathForSelectedRow].row];
    [_tableView reloadData];
    prevPath = nil;
    [self hideButtonSheet];
}

# pragma mark - Button sheet animations

- (void)hideButtonSheet
{
    CGRect windowRect = [[UIScreen mainScreen] bounds];
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:.3];
    _buttonSheet.frame = CGRectMake(0, windowRect.size.height - kButtonSheetHiddenOffset, windowRect.size.width, kButtonSheetHeight);
    [UIView commitAnimations];
}

- (void)showButtonSheet
{
    CGRect windowRect = [[UIScreen mainScreen] bounds];
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:.3];
    _buttonSheet.frame = CGRectMake(0, windowRect.size.height - kButtonSheetVisibleOffset, windowRect.size.width, kButtonSheetHeight);
    [UIView commitAnimations];
}

@end
