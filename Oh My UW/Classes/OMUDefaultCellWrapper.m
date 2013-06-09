//
//  OMUDefaultCellWrapper.m
//  Oh_My_UW
//
//  Created by Eric Lui on 2013-06-08.
//  Copyright (c) 2013 Eric Lui. All rights reserved.
//

#import "OMUDefaultCellWrapper.h"
#import <QuartzCore/QuartzCore.h>

@implementation OMUDefaultCellWrapper

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        // Initialization code
        self.layer.shadowOffset = CGSizeMake(2, 2);
        self.layer.shadowRadius = 5;
        self.layer.shadowOpacity = 0.5;
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
