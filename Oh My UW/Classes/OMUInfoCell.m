//
//  OMUInfoCell.m
//  Oh_My_UW
//
//  Created by Eric Lui on 2013-06-23.
//  Copyright (c) 2013 Eric Lui. All rights reserved.
//

#import "OMUInfoCell.h"
#import "OMUNavigationConstants.h"

@implementation OMUInfoCell

- (id)initWithHeight:(CGFloat) height andText:(NSString *) text {
    CGRect frame = CGRectMake(0.0f, 0.0f, 320.0f, height);
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self setSelectionStyle:UITableViewCellSelectionStyleNone];
        _loadingText = text;
        _wrapper = CGRectInset(frame, WRAPPER_OFFSET_HORIZONTAL, WRAPPER_OFFSET_VERTICAL);
        _shadow = CGRectMake(frame.origin.x + WRAPPER_OFFSET_HORIZONTAL + 1.0, frame.origin.y + WRAPPER_OFFSET_VERTICAL + 1.0, 320.0f - (WRAPPER_OFFSET_HORIZONTAL * 2), WEATHER_CELL_HEIGHT - (WRAPPER_OFFSET_VERTICAL * 2));
    }
    return self;
}

+ (NSString *) reuseIdentifier {
    return @"OMUInfoCellIdentifier";
}

- (void) drawRect:(CGRect)rect {
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextAddRect(context, _shadow);
    CGContextSetFillColorWithColor(context, [UIColor colorWithWhite:0.5 alpha:0.2].CGColor);
    CGContextFillRect(context, _shadow);
    
    CGContextAddRect(context, _wrapper);
    CGContextSetFillColorWithColor(context, [UIColor whiteColor].CGColor);
    CGContextFillRect(context, _wrapper);
    
    [[UIColor grayColor] set];
    [_loadingText drawInRect:CGRectMake(0, _wrapper.size.height - 35.0f, _wrapper.size.width, 15.0f) withFont:[UIFont systemFontOfSize:12.0f] lineBreakMode:NSLineBreakByClipping alignment:NSTextAlignmentCenter];
}

@end
