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
}

@property (nonatomic, retain) NSMutableArray* vectors;

@end
