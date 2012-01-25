//
//  MMMainViewController.h
//  VectorCalc
//
//  Created by Matthew Murdock on 1/18/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MMMainViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>
{
    UITableView* _tableView;
    NSMutableArray* _vectors;
    
    // button sheet holds edit and delete
    UIView* _buttonSheet;
    UIButton* _editButton;
    UIButton* _deleteButton;
    
    // action sheet holds sum, cross-product, longest
    UIView* _actionSheet;
    UIButton* _sumButton;
    UIButton* _findLongestButton;
    UIButton* _crossProductButton;
}

@property (nonatomic, retain) NSMutableArray* vectors;
@property (nonatomic, retain) UITableView* tableView;

# pragma mark actions
- (void)addAction:(id)sender;
- (void)editAction:(id)sender;
- (void)deleteAction:(id)sender;
- (void)sumAction:(id)sender;
- (void)findLongestAction:(id)sender;
- (void)dotProductAction:(id)sender;

# pragma mark animations
- (void)hideButtonSheet;
- (void)showButtonSheet;
- (void)hideActionSheet;
- (void)showActionSheet;

@end
