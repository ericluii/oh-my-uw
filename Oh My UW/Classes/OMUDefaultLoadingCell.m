//
//  OMUDefaultLoadingCell.m
//  Oh_My_UW
//
//  Created by Eric Lui on 2013-06-12.
//  Copyright (c) 2013 Eric Lui. All rights reserved.
//

#import "OMUDefaultLoadingCell.h"
#import "OMUNavigationConstants.h"
#import "OMUImageManager.h"

@implementation OMUDefaultLoadingCell

- (id)initWithHeight:(CGFloat) height andText:(NSString *) text {
    self = [super initWithHeight:height andText:text];
    if (self) {
        [self configure];
    }
    return self;
}

+ (NSString *) reuseIdentifier {
    return @"OMUDefaultLoadingCellIdentifier";
}


- (void) configure {
    UIImage *statusImage = [[OMUImageManager sharedInstance] getImageNamed:@"loading_bar_1.png"];
    UIImageView *activityImageView = [[UIImageView alloc]
                                      initWithImage:statusImage];
    
    activityImageView.animationImages = [NSArray arrayWithObjects:
                                         [[OMUImageManager sharedInstance] getImageNamed:@"loading_bar_1.png"],
                                         [[OMUImageManager sharedInstance] getImageNamed:@"loading_bar_2.png"],
                                         [[OMUImageManager sharedInstance] getImageNamed:@"loading_bar_3.png"],
                                         [[OMUImageManager sharedInstance] getImageNamed:@"loading_bar_4.png"],
                                         [[OMUImageManager sharedInstance] getImageNamed:@"loading_bar_5.png"],
                                         [[OMUImageManager sharedInstance] getImageNamed:@"loading_bar_6.png"],
                                         [[OMUImageManager sharedInstance] getImageNamed:@"loading_bar_7.png"],
                                         [[OMUImageManager sharedInstance] getImageNamed:@"loading_bar_8.png"],
                                         [[OMUImageManager sharedInstance] getImageNamed:@"loading_bar_9.png"],
                                         [[OMUImageManager sharedInstance] getImageNamed:@"loading_bar_10.png"],
                                         nil];
    
    activityImageView.animationDuration = 0.4;
    [activityImageView setFrame:CGRectMake(WRAPPER_OFFSET_HORIZONTAL, self.frame.size.height - WRAPPER_OFFSET_VERTICAL, 320.0f - (WRAPPER_OFFSET_HORIZONTAL * 2), 10.0f)];
    [activityImageView startAnimating];
    [self addSubview:activityImageView];
}

@end
