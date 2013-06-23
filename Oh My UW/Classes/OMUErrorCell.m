//
//  OMUErrorCell.m
//  Oh_My_UW
//
//  Created by Eric Lui on 2013-06-23.
//  Copyright (c) 2013 Eric Lui. All rights reserved.
//

#import "OMUErrorCell.h"
#import "OMUImageManager.h"
#import "OMUNavigationConstants.h"

@implementation OMUErrorCell

- (id)initWithHeight:(CGFloat) height andText:(NSString *) text {
    self = [super initWithHeight:height andText:text];
    if (self) {
        // Initialization code
        [self setSelectionStyle:UITableViewCellSelectionStyleNone];
        _loadingText = text;
        [self configure];
    }
    return self;
}

+ (NSString *) reuseIdentifier {
    return @"OMUErrorCellIdentifier";
}

- (void) configure {
    UIImage *statusImage = [[OMUImageManager sharedInstance] getImageNamed:@"error_bar"];
    UIImageView *imageView = [[UIImageView alloc] initWithImage:statusImage];
    [imageView setFrame:CGRectMake(WRAPPER_OFFSET_HORIZONTAL, self.frame.size.height - WRAPPER_OFFSET_VERTICAL, 320.0f - (WRAPPER_OFFSET_HORIZONTAL * 2), 10.0f)];
    [self addSubview:imageView];
}

@end
