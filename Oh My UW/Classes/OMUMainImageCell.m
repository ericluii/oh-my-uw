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

@implementation OMUMainImageCell {
    MainCellType _cellType;
}

- (id)initWithCellType:(MainCellType) cellType {
    self = [super initWithFrame:CGRectMake(0.0f, 0.0f, 320.0f, MAIN_CELL_HEIGHT)];
    if (self) {
        // Initialization code
        [self setSelectionStyle:UITableViewCellSelectionStyleNone];
        _cellType = cellType;
    }
    return self;
}

+ (NSString *) reuseIdentifier {
    return @"OMUMainImageCellReuseIdentifier";
}

- (void) setHighlighted:(BOOL)highlighted animated:(BOOL)animated {
    [super setHighlighted:highlighted animated:animated];
    
    // Configure the view for the selected state
}

- (void)drawRect:(CGRect)rect {
    CGContextRef context = UIGraphicsGetCurrentContext();

    CGRect wrapper = CGRectInset(rect, WRAPPER_OFFSET_HORIZONTAL, WRAPPER_OFFSET_VERTICAL);
    CGContextSetShadow(context, CGSizeMake(1, 1), 2.0);
    CGContextAddRect(context, wrapper);
    CGContextFillRect(context, wrapper);
    [[self getCellImage] drawInRect:wrapper];
    
    CGRect labelBackground = CGRectMake(WRAPPER_OFFSET_HORIZONTAL, rect.size.height - 20.0f - WRAPPER_OFFSET_VERTICAL, rect.size.width - (2 * WRAPPER_OFFSET_HORIZONTAL), 20.0f);
    CGContextAddRect(context, labelBackground);
    CGContextSetFillColorWithColor(context, [UIColor colorWithWhite:0 alpha:0.7].CGColor);
    CGContextFillRect(context, labelBackground);

    [[UIColor whiteColor] set];
    [[self getCellText] drawAtPoint:CGPointMake(labelBackground.origin.x + 3.0f, labelBackground.origin.y + 2.0f) withFont:[UIFont systemFontOfSize:13.0f]];
}

- (UIImage *) getCellImage {
    switch (_cellType) {
        case schoolOrganizerType:
            return [[OMUImageManager sharedInstance] getImageNamed:@"main_image_school.jpg"];
        case directionType:
            return [[OMUImageManager sharedInstance] getImageNamed:@"main_image_direction"];
        case socialType:
            return [[OMUImageManager sharedInstance] getImageNamed:@"main_image_social.jpg"];
        case newsType:
            return [[OMUImageManager sharedInstance] getImageNamed:@"main_image_news.jpg"];
        case faqType:
            return [[OMUImageManager sharedInstance] getImageNamed:@"main_image_faq.jpg"];
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
