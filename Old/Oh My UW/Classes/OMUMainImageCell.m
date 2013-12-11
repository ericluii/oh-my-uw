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

@implementation OMUMainImageCell

static NSString * cellReuseIdentifer = @"OMUMainImageCellReuseIdentifier";

- (id)init {
    self = [super initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellReuseIdentifer];
    if (self) {
        // Initialization code
        CGRect frame = CGRectMake(0.0f, 0.0f, 320.0f, MAIN_CELL_HEIGHT);
        [self setFrame:frame];
        [self setSelectionStyle:UITableViewCellSelectionStyleNone];
        [self setupDrawConstantsWithFrame:frame];
    }
    return self;
}

+ (NSString *) reuseIdentifier {
    return cellReuseIdentifer;
}

- (void) setHighlighted:(BOOL)highlighted animated:(BOOL)animated {
    [super setHighlighted:highlighted animated:animated];
    
    // Configure the view for the selected state
    [self setNeedsDisplay];
}

- (void) configureForCellType:(MainCellType)cellType {
    _cellImage = [self getCellImageForCellType:cellType];
    _cellText = [self getCellTextForCellType:cellType];
}

- (void)drawRect:(CGRect)rect {
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextAddRect(context, _shadowX);
    CGContextSetFillColorWithColor(context, _shadowColor.CGColor);
    CGContextFillRect(context, _shadowX);
    CGContextAddRect(context, _shadowY);
    CGContextSetFillColorWithColor(context, _shadowColor.CGColor);
    CGContextFillRect(context, _shadowY);

    CGContextAddRect(context, _imageWrapper);
    CGContextFillRect(context, _imageWrapper);
    if ([self isHighlighted]) {
        [_cellImage drawInRect:_imageWrapper blendMode:kCGBlendModeLuminosity alpha:1];
    } else {
        [_cellImage drawInRect:_imageWrapper];
    }

    CGContextAddRect(context, _labelWrapper);
    CGContextSetFillColorWithColor(context, [self isHighlighted] ? _highlightedLabelColor.CGColor : _labelColor.CGColor);
    CGContextFillRect(context, _labelWrapper);

    if ([self isHighlighted]) {
        [[UIColor grayColor] set];
    } else {
        [[UIColor whiteColor] set];
    }
    [_cellText drawAtPoint:_textPoint withFont: _font];
}

- (void) setupDrawConstantsWithFrame:(CGRect)frame {    
    _imageWrapper = CGRectInset(frame, WRAPPER_OFFSET_HORIZONTAL, WRAPPER_OFFSET_VERTICAL);
    _labelWrapper = CGRectMake(WRAPPER_OFFSET_HORIZONTAL, frame.size.height - 20.0f - WRAPPER_OFFSET_VERTICAL, frame.size.width - (2 * WRAPPER_OFFSET_HORIZONTAL), 20.0f);
    
    _textPoint = CGPointMake(_labelWrapper.origin.x + 3.0f, _labelWrapper.origin.y + 2.0f);
    
    _shadowX = CGRectMake(CGRectGetMinX(_imageWrapper) + 1.0f, CGRectGetMaxY(_imageWrapper), CGRectGetWidth(_imageWrapper), 1.0f);
    _shadowY = CGRectMake(CGRectGetMaxX(_imageWrapper), CGRectGetMinY(_imageWrapper) + 1.0f, 1.0f, CGRectGetHeight(_imageWrapper));
    
    _shadowColor = [UIColor colorWithRed:209/255.0 green:209/255.0 blue:209/255.0 alpha:1];
    _labelColor = [UIColor colorWithWhite:0 alpha:0.7];
    _highlightedLabelColor = [UIColor colorWithRed:1 green:1 blue:102/255.0 alpha:0.7];
    
    _font = [UIFont systemFontOfSize:13.0f];
}

- (UIImage *) getCellImageForCellType:(MainCellType) cellType {
    switch (cellType) {
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

- (NSString *) getCellTextForCellType:(MainCellType) cellType{
    switch (cellType) {
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
