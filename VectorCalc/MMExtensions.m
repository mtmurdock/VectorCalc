//
//  MMExtensions.m
//  VectorCalc
//
//  Created by Matthew Murdock on 1/19/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MMExtensions.h"

@implementation UITableView (MMExtensions)

+ (UITableView*) tableViewForViewController:(UIViewController<UITableViewDelegate, UITableViewDataSource>*)vc
{
    UITableView* tableView = [[UITableView alloc] init];
    tableView.frame = vc.view.bounds;
    tableView.tableFooterView = [[[UIView alloc] initWithFrame:CGRectZero] autorelease];
    tableView.backgroundColor = [UIColor underPageBackgroundColor];
    
    tableView.dataSource = vc;
    tableView.delegate = vc;
    return tableView;
}

@end
