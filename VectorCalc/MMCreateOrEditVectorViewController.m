//
//  MMCreateOrEditVectorViewController.m
//  VectorCalc
//
//  Created by Matthew Murdock on 1/19/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MMCreateOrEditVectorViewController.h"
#import "MMMainViewController.h"
#import "MMExtensions.h"

#define kStdButtonHeight	40.0
#define kPadding            5.0
#define kSliderWidth	    250.0
#define kTextFieldHeight    30.0
#define kLabelWidth         80.0

@implementation MMCreateOrEditVectorViewController
@synthesize vector = _vector;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
    }
    return self;
}

- (void) viewDidLoad
{
    // init elements
    _xLabel = [[UILabel alloc] init];
    _yLabel = [[UILabel alloc] init];
    _zLabel = [[UILabel alloc] init];
    
    _xInput = [[UISlider vectorSlider] retain];
    _yInput = [[UISlider vectorSlider] retain];
    _zInput = [[UISlider vectorSlider] retain];
    
    _okButton = [[UIButton buttonWithType:UIButtonTypeRoundedRect] retain];
    _cancelButton = [[UIButton buttonWithType:UIButtonTypeRoundedRect] retain];;
    
    // set data
    [_xLabel setText:@"X: 0.00"];
    [_yLabel setText:@"Y: 0.00"];
    [_zLabel setText:@"Z: 0.00"];
    
    [_xInput addTarget:self action:@selector(xSliderAction:) forControlEvents:UIControlEventValueChanged];
    [_yInput addTarget:self action:@selector(ySliderAction:) forControlEvents:UIControlEventValueChanged];
    [_zInput addTarget:self action:@selector(zSliderAction:) forControlEvents:UIControlEventValueChanged];
    
    [_okButton setTitle:@"Ok" forState:UIControlStateNormal];
    [_okButton addTarget:self action:@selector(okButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [_cancelButton setTitle:@"Cancel" forState:UIControlStateNormal];
    [_cancelButton addTarget:self action:@selector(cancelButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    
    // init frames
    CGRect windowFrame = self.view.bounds;
    
    // label frames
    CGRect xLabelFrame = CGRectMake(kPadding, kPadding, kLabelWidth, kTextFieldHeight);
    
    CGRect yLabelFrame = CGRectMake(kPadding, 3*kPadding + kTextFieldHeight, kLabelWidth, kTextFieldHeight);
    
    CGRect zLabelFrame = CGRectMake(kPadding, 5*kPadding + 2*kTextFieldHeight, kLabelWidth, kTextFieldHeight);
    
    // input frames
    int inputOffset = windowFrame.size.width - kSliderWidth - kPadding;
    CGRect xInputFrame = CGRectMake(inputOffset, kPadding, kSliderWidth, kTextFieldHeight);
    CGRect yInputFrame = CGRectMake(inputOffset, 3*kPadding + kTextFieldHeight, kSliderWidth, kTextFieldHeight);
    CGRect zInputFrame = CGRectMake(inputOffset, 5*kPadding + 2*kTextFieldHeight, kSliderWidth, kTextFieldHeight);
    
    // button frames
    CGRect okButtonFrame = CGRectInset(CGRectMake(0, 
                                      windowFrame.size.height - kStdButtonHeight - 2*kPadding,
                                      windowFrame.size.width / 2, 
                                      kStdButtonHeight + 2*kPadding), kPadding, kPadding);
    CGRect cancelButtonFrame = CGRectInset(CGRectMake(windowFrame.size.width / 2, 
                                      windowFrame.size.height - kStdButtonHeight - 2*kPadding, 
                                      windowFrame.size.width / 2, 
                                      kStdButtonHeight + 2*kPadding), kPadding, kPadding);
    
    // apply frames
    [_xLabel setFrame:xLabelFrame];
    [_yLabel setFrame:yLabelFrame];
    [_zLabel setFrame:zLabelFrame];
    
    [_xInput setFrame:xInputFrame];
    [_yInput setFrame:yInputFrame];
    [_zInput setFrame:zInputFrame];
    
    [_okButton setFrame:okButtonFrame];
    [_cancelButton setFrame:cancelButtonFrame];
    
    // add views
    [self.view addSubview:_xLabel];
    [self.view addSubview:_yLabel];
    [self.view addSubview:_zLabel];
    
    [self.view addSubview:_xInput];
    [self.view addSubview:_yInput];
    [self.view addSubview:_zInput];
    
    [self.view addSubview:_okButton];
    [self.view addSubview:_cancelButton];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return YES;
}

- (void) xSliderAction:(id)sender
{
    _xLabel.text = [NSString stringWithFormat:@"X: %.2f", [_xInput value]];
}

- (void) ySliderAction:(id)sender
{
    _yLabel.text = [NSString stringWithFormat:@"Y: %.2f", [_yInput value]];    
}

- (void) zSliderAction:(id)sender
{
    _zLabel.text = [NSString stringWithFormat:@"Z: %.2f", [_zInput value]];
}

- (void) okButtonAction:(id)sender
{
    float x = ((int)(_xInput.value * 100)) / 100;
    float y = ((int)(_yInput.value * 100)) / 100;
    float z = ((int)(_zInput.value * 100)) / 100;
    
    // if new mode, create new and add to list
    if (self.vector == nil) {
        MMVector* newVector = [[MMVector alloc] initWithX:x Y:y Z:z];
        // add to list....
        MMMainViewController* parent = (MMMainViewController*)[self.navigationController parentViewController];
        [parent.vectors addObject:newVector];
    }
    // if edit mode, change value
    else
    {
        self.vector.x = x;
        self.vector.y = y;
        self.vector.z = z;
    }
    
    
    // pop controller
    [self.navigationController popViewControllerAnimated:YES];
}

- (void) cancelButtonAction:(id)sender
{
    
}

@end
