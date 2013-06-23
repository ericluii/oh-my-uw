//
//  OMUMainImageCell.m
//  Oh_My_UW
//
//  Created by Eric Lui on 2013-06-15.
//  Copyright (c) 2013 Eric Lui. All rights reserved.
//

#import "OMUMainImageCell.h"
#import "OMUNavigationConstants.h"
#import "OMUImageManager.h"
#import <QuartzCore/QuartzCore.h>

@implementation OMUMainImageCell {
    MainCellType _cellType;
}

- (id)initWithCellType:(MainCellType) cellType {
    CGRect frame = CGRectMake(0.0f, 0.0f, 320.0f, MAIN_CELL_HEIGHT);
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self setSelectionStyle:UITableViewCellSelectionStyleNone];
        _cellType = cellType;
        _cellImage = [self getCellImage];
        _cellText = [self getCellText];
        _imageWrapper = CGRectInset(frame, WRAPPER_OFFSET_HORIZONTAL, WRAPPER_OFFSET_VERTICAL);
        _labelWrapper = CGRectMake(WRAPPER_OFFSET_HORIZONTAL, frame.size.height - 20.0f - WRAPPER_OFFSET_VERTICAL, frame.size.width - (2 * WRAPPER_OFFSET_HORIZONTAL), 20.0f);
    }
    return self;
}

+ (NSString *) reuseIdentifier {
    return @"OMUMainImageCellReuseIdentifier";
}

- (void) setHighlighted:(BOOL)highlighted animated:(BOOL)animated {
    [super setHighlighted:highlighted animated:animated];
    
    // Configure the view for the selected state
    [self setNeedsDisplay];
}

- (void)drawRect:(CGRect)rect {
    CGContextRef context = UIGraphicsGetCurrentContext();

    CGContextAddRect(context, _imageWrapper);
    CGContextFillRect(context, _imageWrapper);
    if ([self isHighlighted]) {
        [_cellImage drawInRect:_imageWrapper blendMode:kCGBlendModeLuminosity alpha:1];
    } else {
        [_cellImage drawInRect:_imageWrapper];
    }

    CGContextAddRect(context, _labelWrapper);
    CGContextSetFillColorWithColor(context, [self isHighlighted] ? [UIColor colorWithRed:1 green:1 blue:102/255.0 alpha:0.7].CGColor : [UIColor colorWithWhite:0 alpha:0.7].CGColor);
    CGContextFillRect(context, _labelWrapper);

    if ([self isHighlighted]) {
        [[UIColor grayColor] set];
    } else {
        [[UIColor whiteColor] set];
    }
    [_cellText drawAtPoint:CGPointMake(_labelWrapper.origin.x + 3.0f, _labelWrapper.origin.y + 2.0f) withFont:[UIFont systemFontOfSize:13.0f]];
}

- (UIImage *) getCellImage {
    switch (_cellType) {
        case schoolOrganizerType:
            return [[OMUImageManager sharedInstance] getImageNamed:@"main_image_school"];
        case directionType:
            return [[OMUImageManager sharedInstance] getImageNamed:@"main_image_direction"];
        case socialType:
            return [[OMUImageManager sharedInstance] getImageNamed:@"main_image_social"];
        case newsType:
            return [[OMUImageManager sharedInstance] getImageNamed:@"main_image_news"];
        case faqType:
            return [[OMUImageManager sharedInstance] getImageNamed:@"main_image_faq"];
        default:
            return nil;
    }
}

- (NSString *) getCellText {
    switch (_cellType) {
        case schoolOrganizerType:
            return @" My School Organizer";
        case directionType:
            return @" Find My Way Around Waterloo";
        case socialType:
            return @" UW Social Feed";
        case newsType:
            return @" Latest News";
        case faqType:
            return @" What Every UW Student Should Know";
        default:
            return @"";
    }
}

@end
