//
//  OMUMainImageCell.m
//  Oh_My_UW
//
//  Created by Eric Lui on 2013-06-15.
//  Copyright (c) 2013 Eric Lui. All rights reserved.
//

#import "OMUMainImageCell.h"
#import "OMUNavigationConstants.h"

@implementation OMUMainImageCell {
    MainCellType _cellType;
}

- (id)initWithCellType:(MainCellType) cellType {
    self = [super initWithFrame:CGRectMake(0.0f, 0.0f, 320.0f, MAIN_CELL_HEIGHT)];
    if (self) {
        // Initialization code
        [self setSelectionStyle:UITableViewCellSelectionStyleNone];
        _cellType = cellType;
        [self configure];
    }
    return self;
}

+ (NSString *) reuseIdentifier {
    return @"OMUMainImageCellReuseIdentifier";
}

- (void) setHighlighted:(BOOL)highlighted animated:(BOOL)animated {
    [super setHighlighted:highlighted animated:animated];
    
    // Configure the view for the selected state
    if (highlighted) {
        [_backgroundImage setAlpha:0.5];
        [_overlayText setBackgroundColor:[UIColor colorWithRed:1 green:1 blue:153/255.0 alpha:0.7]];
        [_overlayText setTextColor:[UIColor colorWithWhite:0.5 alpha:1]];
    } else {
        [_backgroundImage setAlpha:1];
        [_overlayText setBackgroundColor:[UIColor colorWithWhite:0 alpha:0.7]];
        [_overlayText setTextColor:[UIColor whiteColor]];
    }
}

- (void) configure {
    _wrapper = [[OMUDefaultCellWrapper alloc] initWithFrame:CGRectMake(WRAPPER_OFFSET_HORIZONTAL, WRAPPER_OFFSET_VERTICAL, 320.0f - (WRAPPER_OFFSET_HORIZONTAL * 2), MAIN_CELL_HEIGHT - (WRAPPER_OFFSET_VERTICAL * 2))];
    
    _backgroundImage = [[UIImageView alloc] initWithImage:[self getCellImage]];
    [_backgroundImage setBackgroundColor:[UIColor blackColor]];
    [_backgroundImage setContentMode:UIViewContentModeScaleAspectFill];
    [_backgroundImage setClipsToBounds:YES];
    [_backgroundImage setFrame:CGRectMake(0, 0, _wrapper.frame.size.width, _wrapper.frame.size.height)];
    [_wrapper addSubview:_backgroundImage];
    
    _overlayText = [[UILabel alloc] init];
    [_overlayText setText:[self getCellText]];
    [_overlayText setFont:[UIFont systemFontOfSize:13.0f]];
    [_overlayText setFrame:CGRectMake(0, _wrapper.frame.size.height - 20.0f, _wrapper.frame.size.width, 20.0f)];
    [_wrapper addSubview:_overlayText];
    
    [self addSubview:_wrapper];
}

- (UIImage *) getCellImage {
    switch (_cellType) {
        case schoolOrganizerType:
            return [UIImage imageNamed:@"main_image_school.jpg"];
        case directionType:
            return [UIImage imageNamed:@"main_image_direction"];
        case socialType:
            return [UIImage imageNamed:@"main_image_social.jpg"];
        case newsType:
            return [UIImage imageNamed:@"main_image_news.jpg"];
        case faqType:
            return [UIImage imageNamed:@"main_image_faq.jpg"];
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
