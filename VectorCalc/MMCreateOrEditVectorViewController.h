//
//  MMCreateOrEditVectorViewController.h
//  VectorCalc
//
//  Created by Matthew Murdock on 1/19/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MMVector.h"

@interface MMCreateOrEditVectorViewController : UIViewController
{
    // labels
    UILabel* _xLabel;
    UILabel* _yLabel;
    UILabel* _zLabel;
    //sliders
    UISlider* _xInput;
    UISlider* _yInput;
    UISlider* _zInput;
    //buttons
    UIButton* _okButton;
    UIButton* _cancelButton;
    MMVector* _vector;
    UIViewController* _parent;
}

@property (nonatomic, retain) MMVector* vector;
@property (nonatomic, retain) UIViewController* parent;

# pragma mark actions
- (void) xSliderAction:(id)sender;
- (void) ySliderAction:(id)sender;
- (void) zSliderAction:(id)sender;
- (void) okButtonAction:(id)sender;
- (void) cancelButtonAction:(id)sender;

@end
