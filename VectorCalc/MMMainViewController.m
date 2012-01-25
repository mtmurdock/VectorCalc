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
#define kActionSheetVisibleOffset  164.0
#define kActionSheetHiddenOffset   94.0
#define kActionSheetHeight         100.0

@interface MMMainViewController ()

- (void) initTableView;
- (void) initButtonSheet;
- (void) initActionSheet;

@end

@implementation MMMainViewController
@synthesize vectors = _vectors, tableView = _tableView;

# pragma mark initialization methods

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        _vectors = [[NSMutableArray array] retain];
        
        // add two vectors to list
        [_vectors addObject:[[MMVector alloc] initWithX:0.0f Y:0.0f Z:0.0f]];
        [_vectors addObject:[[MMVector alloc] initWithX:0.0f Y:0.0f Z:0.0f]];
    }
    return self;
}

- (void) initTableView
{
    // set up table view
    _tableView = [UITableView tableViewForViewController:self];
}

- (void) initButtonSheet
{
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
}

- (void) initActionSheet
{
    // alloc and init
    CGRect windowRect = [[UIScreen mainScreen] bounds];
    _actionSheet = [[UIView alloc] init];
    _sumButton = [[UIButton buttonWithType:UIButtonTypeRoundedRect] retain];
    _findLongestButton = [[UIButton buttonWithType:UIButtonTypeRoundedRect] retain];
    _crossProductButton = [[UIButton buttonWithType:UIButtonTypeRoundedRect] retain];
    
    // add callbacks
    [_sumButton addTarget:self action:@selector(sumAction:) forControlEvents:UIControlEventTouchUpInside];
    [_findLongestButton addTarget:self action:@selector(findLongestAction:) forControlEvents:UIControlEventTouchUpInside];
    [_crossProductButton addTarget:self  action:@selector(dotProductAction:) forControlEvents:UIControlEventTouchUpInside];
    
    // set look-and-feel stuff
    [_sumButton setTitle:@"Sum" forState:UIControlStateNormal];
    [_findLongestButton setTitle:@"Longest" forState:UIControlStateNormal];
    [_crossProductButton setTitle:@"Dot Product of first two" forState:UIControlStateNormal];
    _actionSheet.backgroundColor = [UIColor whiteColor];
    
    // calculate frames
    _actionSheet.frame = CGRectMake(0, windowRect.size.height - kActionSheetHiddenOffset, windowRect.size.width, kActionSheetHeight);
    _sumButton.frame = CGRectInset(CGRectMake(0, 0, _actionSheet.frame.size.width / 2, kStdButtonHeight + 2*kPadding), kPadding, kPadding);
    _findLongestButton.frame = CGRectInset(CGRectMake(_actionSheet.frame.size.width / 2, 0, _actionSheet.frame.size.width / 2, kStdButtonHeight + 2*kPadding), kPadding, kPadding);
    _crossProductButton.frame = CGRectInset(CGRectMake(0, kStdButtonHeight + 2*kPadding, _actionSheet.frame.size.width, kStdButtonHeight + 2*kPadding), kPadding, kPadding);
    
    // add views
    [_actionSheet addSubview:_sumButton];
    [_actionSheet addSubview:_findLongestButton];
    [_actionSheet addSubview:_crossProductButton];
}

# pragma mark application lifecycle

- (void) viewDidLoad
{
    // set up navigation bar
    self.navigationItem.title = @"Vectors";
    UIBarButtonItem* newVectorButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addAction:)];
    self.navigationItem.rightBarButtonItem = newVectorButton;
    
    // init gui
    [self initTableView];
    [self initButtonSheet];
    [self initActionSheet];
    
    // add views to main view
    [self.view addSubview:_buttonSheet];
    [self.view addSubview:_tableView];
    [self.view addSubview:_actionSheet];
    [self.view bringSubviewToFront:_actionSheet];
    [self.view bringSubviewToFront:_buttonSheet];
}

- (void) viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [_tableView reloadData];
    [self hideButtonSheet];
    [self showActionSheet];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return YES;
}

#pragma mark UITableViewDelegate/DataSource

- (UITableViewCell*) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // dequeue/init cell
    MMVectorCell* cell = [tableView dequeueReusableCellWithIdentifier:@"vector"];
    if(!cell) {
        cell = [[MMVectorCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"vector"];
        [cell setFrame:CGRectMake(0, 0, self.view.bounds.size.width, 50)];
    }
    
    // set cell's data
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
    // if user has tapped on a cell which is already selected
    if ([prevPath isEqual:indexPath])
    {
        // deselect that cell
        [tableView deselectRowAtIndexPath:indexPath animated:true];
        [prevPath release];
        prevPath = nil;
        
        [self hideButtonSheet];
        [self showActionSheet];
    }
    else
    {
        // else, select that cell
        [tableView selectRowAtIndexPath:indexPath animated:true scrollPosition:UITableViewScrollPositionNone];
        [prevPath release];
        prevPath = [indexPath copy];
        
        [self showButtonSheet];
        [self hideActionSheet];
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

# pragma mark actions

- (void)addAction:(id)sender
{
    // go to create screen
    MMCreateOrEditVectorViewController* vc = [[MMCreateOrEditVectorViewController alloc] init];
    vc.parent = self;
    [self.navigationController pushViewController:vc animated:true];
}

- (void)editAction:(id)sender
{
    // go to edit screen (which is also create screen)
    MMVector* vector = [_vectors objectAtIndex:[_tableView indexPathForSelectedRow].row];
    MMCreateOrEditVectorViewController* vc = [[MMCreateOrEditVectorViewController alloc] init];
    vc.vector = vector; // set vector so we'll be in edit mode
    vc.parent = self;
    [self.navigationController pushViewController:vc animated:true];
    
}

- (void)deleteAction:(id)sender
{
    // remove vector from list
    [_vectors removeObjectAtIndex:[_tableView indexPathForSelectedRow].row];
    // reload data and update GUI
    [_tableView reloadData];
    [_tableView deselectRowAtIndexPath:prevPath animated:true];
    prevPath = nil;
    [self hideButtonSheet];
    [self showActionSheet];
}

- (void)sumAction:(id)sender
{
    if (_vectors.count > 0) {
        
        MMVector* sum = [[[MMVector alloc] initWithX:0 Y:0 Z:0] autorelease];
        // sum vectors
        for (MMVector* vec in _vectors)
        {
            sum = [MMVector sumOf:sum And:vec];
        }
        
        // display result
        NSString* message = [NSString stringWithFormat:@"(%.2f, %.2f, %.2f)", sum.x, sum.y, sum.z];
        UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"Sum" message:message delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
        [alert show];
    } else {
        // if list is empty, display error message
        UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"Sum" message:@"You must add vectors to the list." delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
        [alert show];
    }
}

- (void)findLongestAction:(id)sender
{
    if(_vectors.count > 0) {
        // search for longest
        MMVector* longest = [_vectors objectAtIndex:0];
        for (MMVector* vect in _vectors)
        {
            if ([vect magnitude] > [longest magnitude])
                longest = vect;
        }
        
        // display result
        NSString* message = [NSString stringWithFormat:@"(%.2f, %.2f, %.2f)", longest.x, longest.y, longest.z];
        UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"Longest" message:message delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
        [alert show];
    } else {
        // if list is empty, display error message
        UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"Longest" message:@"You must add vectors to the list." delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
        [alert show];
    }
}

- (void)dotProductAction:(id)sender
{
    if (_vectors.count >= 2) {
        float dotProduct = [MMVector dotProductOf:[_vectors objectAtIndex:0] And:[_vectors objectAtIndex:1]];
        
        // display result
        NSString* message = [NSString stringWithFormat:@"%.2f", dotProduct];
        UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"Dot Product" message:message delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
        [alert show]; 
    } else {
        // if list does not have at least 2 vectors, display error message
        UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"Dot Product" message:@"You must add vectors to the list." delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
        [alert show];
    }
}

# pragma mark animations

- (void)hideButtonSheet
{
    // shift button sheet down, and out of view
    CGRect windowRect = [[UIScreen mainScreen] bounds];
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:.3];
    _buttonSheet.frame = CGRectMake(0, windowRect.size.height - kButtonSheetHiddenOffset, windowRect.size.width, kButtonSheetHeight);
    [UIView commitAnimations];
}

- (void)showButtonSheet
{
    // shift button sheet up to be visisble
    CGRect windowRect = [[UIScreen mainScreen] bounds];
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:.3];
    _buttonSheet.frame = CGRectMake(0, windowRect.size.height - kButtonSheetVisibleOffset, windowRect.size.width, kButtonSheetHeight);
    _tableView.frame = CGRectMake(0,0,_tableView.frame.size.width,windowRect.size.height - kButtonSheetVisibleOffset);
    [UIView commitAnimations];
}

- (void)hideActionSheet
{
    // shift action sheet down, and out of view.
    CGRect windowRect = [[UIScreen mainScreen] bounds];
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:.3];
    _actionSheet.frame = CGRectMake(0, windowRect.size.height - kActionSheetHiddenOffset, windowRect.size.width, kActionSheetHeight);
    [UIView commitAnimations];
}

- (void)showActionSheet
{
    // shift action sheet up to be visible.
    CGRect windowRect = [[UIScreen mainScreen] bounds];
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:.3];
    _actionSheet.frame = CGRectMake(0, windowRect.size.height - kActionSheetVisibleOffset, windowRect.size.width, kActionSheetHeight);
    _tableView.frame = CGRectMake(0,0,_tableView.frame.size.width,windowRect.size.height - kActionSheetVisibleOffset);
    [UIView commitAnimations];
}

@end
