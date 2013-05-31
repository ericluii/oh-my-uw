//
//  OMUSideMenu.m
//  Oh_My_UW
//
//  Created by Eric Lui on 2013-05-30.
//  Copyright (c) 2013 Eric Lui. All rights reserved.
//

#import "OMUSideMenu.h"

@implementation OMUSideMenu

- (id)init {
    self = [super initWithFrame:CGRectMake(0, 0, 240, [UIScreen mainScreen].bounds.size.height)];
    if (self) {
        // Initialization code
        [self setBackgroundColor:[UIColor blueColor]];
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
