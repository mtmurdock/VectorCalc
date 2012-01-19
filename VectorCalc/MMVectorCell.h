//
//  MMVectorCell.h
//  VectorCalc
//
//  Created by Matthew Murdock on 1/19/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MMVector.h"

@interface MMVectorCell : UITableViewCell
{
    MMVector* _vector;
}

@property (nonatomic, retain) MMVector* vector;

@end
