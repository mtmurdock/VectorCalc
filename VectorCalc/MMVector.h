//
//  Vector.h
//  VectorCalc
//
//  Created by Matthew Murdock on 1/19/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

// abstract representation of a 3D vector
@interface MMVector : NSObject
{
    float _x;
    float _y;
    float _z;
}

@property (nonatomic) float x, y, z;

# pragma mark instance methods
- (id) initWithX:(float)X Y:(float)Y Z:(float)Z;
- (float) magnitude;

# pragma mark class methods
+ (float) dotProductOf:(MMVector*)v1 And:(MMVector*)v2;
+ (MMVector*) sumOf:(MMVector*)v1 And:(MMVector*)v2;

@end
