//
//  Vector.h
//  VectorCalc
//
//  Created by Matthew Murdock on 1/19/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MMVector : NSObject
{
    float _x;
    float _y;
    float _z;
}

@property (nonatomic) float x, y, z;

- (id) initWithX:(float)X Y:(float)Y Z:(float)Z;
- (float) magnitude;

+ (float) dotProductOf:(MMVector*)v1 And:(MMVector*)v2;
+ (MMVector*) sumOf:(MMVector*)v1 And:(MMVector*)v2;

@end
