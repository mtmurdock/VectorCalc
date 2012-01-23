//
//  MMVectorCell.m
//  VectorCalc
//
//  Created by Matthew Murdock on 1/19/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MMVectorCell.h"

static NSString* formatString = @"X:%.2f\t\t\tY:%.2f\t\t\tZ:%.2f";

@implementation MMVectorCell
@synthesize vector = _vector;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self.textLabel setText:[NSString stringWithFormat:formatString, 0, 0, 0]];
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
}

- (void) setVector:(MMVector *)vector
{
    _vector = vector;
    [self.textLabel setText:[NSString stringWithFormat:formatString, vector.x, vector.y, vector.z]];
}

@end
