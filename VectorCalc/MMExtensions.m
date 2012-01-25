//
//  MMExtensions.m
//  VectorCalc
//
//  Created by Matthew Murdock on 1/19/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MMExtensions.h"

@implementation UITableView (MMExtensions)

// This is largely taken from UICatalog
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


@implementation UITextField (MMExtensions)

// This too is largely taken from UICatalog
+ (UITextField *)textFieldRounded
{
	UITextField* textFieldRounded;
		textFieldRounded = [[UITextField alloc] init];
		
    textFieldRounded.borderStyle = UITextBorderStyleRoundedRect;
    textFieldRounded.textColor = [UIColor blackColor];
    textFieldRounded.font = [UIFont systemFontOfSize:17.0];
    textFieldRounded.backgroundColor = [UIColor whiteColor];
    textFieldRounded.autocorrectionType = UITextAutocorrectionTypeNo;	// no auto correction support
    
    textFieldRounded.keyboardType = UIKeyboardTypeDefault;
    textFieldRounded.returnKeyType = UIReturnKeyDone;
    
    textFieldRounded.clearButtonMode = UITextFieldViewModeWhileEditing;	// has a clear 'x' button to the right

	return [textFieldRounded autorelease];
}

@end

@implementation UISlider (MMExtensions)

+ (UISlider *) vectorSlider
{
    UISlider* sliderCtl = [[UISlider alloc] init];
    
    // in case the parent view draws with a custom color or gradient, use a transparent color
    sliderCtl.backgroundColor = [UIColor clearColor];
    
    sliderCtl.minimumValue = -10.0;
    sliderCtl.maximumValue = 10.0;
    sliderCtl.continuous = YES;
    sliderCtl.value = 0;
    
    return [sliderCtl autorelease];
}

@end