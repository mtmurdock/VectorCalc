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

@implementation MMMainViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        _tableView = [UITableView tableViewForViewController:self];
        [self.view addSubview:_tableView];
        
        _vectors = [[NSMutableArray array] retain];
        
        //test code:
        [_vectors addObject:[[MMVector alloc] initWithX:0.0f Y:0.0f Z:0.0f]];
        [_vectors addObject:[[MMVector alloc] initWithX:0.0f Y:0.0f Z:0.0f]];
        [_vectors addObject:[[MMVector alloc] initWithX:0.0f Y:0.0f Z:0.0f]];
        [_vectors addObject:[[MMVector alloc] initWithX:0.0f Y:0.0f Z:0.0f]];
    }
    return self;
}

- (void) viewDidLoad
{
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

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

- (int) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _vectors.count;
}

- (float) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}

@end
