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
    UIView* _buttonSheet;
    UIButton* _editButton;
    UIButton* _deleteButton;
}

@property (nonatomic, retain) NSMutableArray* vectors;
@property (nonatomic, retain) UITableView* tableView;

- (void)addAction:(id)sender;
- (void)editAction:(id)sender;
- (void)deleteAction:(id)sender;

- (void)hideButtonSheet;
- (void)showButtonSheet;

@end
