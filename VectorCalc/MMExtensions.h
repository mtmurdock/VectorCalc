//
//  MMExtensions.h
//  VectorCalc
//
//  Created by Matthew Murdock on 1/19/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MMVector.h"

@interface UITableView ()

+ (UITableView*) tableViewForViewController:(UIViewController*)vc;

@end

@interface UITextField ()

+ (UITextField *)textFieldRounded;

@end

@interface UISlider ()

+ (UISlider *)vectorSlider;

@end