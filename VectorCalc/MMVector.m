//
//  Vector.m
//  VectorCalc
//
//  Created by Matthew Murdock on 1/19/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MMVector.h"

@implementation MMVector
@synthesize x = _x, y = _y, z = _z;

- (id) initWithX:(float)X Y:(float)Y Z:(float)Z
{
    self = [super init];
    
    _x = X;
    _y = Y;
    _z = Z;
    
    return self;
}

- (float) magnitude
{
    return sqrtf(powf(_x, 2) + powf(_y, 2) + powf(_z, 2));
}

# pragma mark class methods

+ (float) dotProductOf:(MMVector*)v1 And:(MMVector*)v2
{
    return (v1.x * v2.x) + (v1.y * v2.y) + (v1.z * v2.z);
}

+ (MMVector*) sumOf:(MMVector*)v1 And:(MMVector*)v2
{
    return [[[MMVector alloc] initWithX:(v1.x + v2.x) Y:(v1.y + v2.y) Z:(v1.z + v2.z)] autorelease];
}

@end
