//
//  OMUWeatherCell.m
//  Oh_My_UW
//
//  Created by Eric Lui on 2013-06-08.
//  Copyright (c) 2013 Eric Lui. All rights reserved.
//

#import "OMUWeatherCell.h"
#import "OMUMainWeatherCellView.h"
#import "OMUWeatherModel.h"
#import "OMUNavigationConstants.h"
#import "OMUMinorWeatherCellView.h"

@implementation OMUWeatherCell

- (id)initWithWeather:(OMUWeatherModel *) weather {
    CGRect frame = CGRectMake(0.0f, 0.0f, 320.0f, WEATHER_CELL_HEIGHT);
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        _weather = weather;
        [self setSelectionStyle:UITableViewCellSelectionStyleNone];
        [self configure];
        _wrapper = CGRectInset(frame, WRAPPER_OFFSET_HORIZONTAL, WRAPPER_OFFSET_VERTICAL);
        _shadowX = CGRectMake(CGRectGetMinX(_wrapper) + 1.0f, CGRectGetMaxY(_wrapper), CGRectGetWidth(_wrapper), 1.0f);
        _shadowY = CGRectMake(CGRectGetMaxX(_wrapper), CGRectGetMinY(_wrapper) + 1.0f, 1.0f, CGRectGetHeight(_wrapper));
        _shadowColor = [UIColor colorWithWhite:0.5 alpha:0.2];
        _wrapperColor = [UIColor whiteColor];
    }
    return self;
}

+ (NSString *) reuseIdentifier {
    return @"OMUWeatherCellReuseID";
}

- (void)drawRect:(CGRect)rect {
    CGContextRef context = UIGraphicsGetCurrentContext();

    CGContextAddRect(context, _shadowX);
    CGContextSetFillColorWithColor(context, _shadowColor.CGColor);
    CGContextFillRect(context, _shadowX);
    CGContextAddRect(context, _shadowY);
    CGContextSetFillColorWithColor(context, _shadowColor.CGColor);
    CGContextFillRect(context, _shadowY);
    
    CGContextAddRect(context, _wrapper);
    CGContextSetFillColorWithColor(context, _wrapperColor.CGColor);
    CGContextFillRect(context, _wrapper);
}

- (void) configure {    
    _scroller = [[UIScrollView alloc] initWithFrame:CGRectMake(WRAPPER_OFFSET_HORIZONTAL, WRAPPER_OFFSET_VERTICAL, 320.0f - (WRAPPER_OFFSET_HORIZONTAL * 2), WEATHER_CELL_HEIGHT - (WRAPPER_OFFSET_VERTICAL * 2))];
    [_scroller setDelegate:self];
    [_scroller setScrollEnabled:YES];
    
    _mainWeatherView = [[OMUMainWeatherCellView alloc] initWithWeather: _weather];
    [_scroller addSubview:_mainWeatherView];
    
    CGFloat xOrigin = _mainWeatherView.frame.size.width + 5.0f;
    for (NSDictionary *day in _weather.restOfWeek) {
        OMUMinorWeatherCellView * dayOfWeek = [[OMUMinorWeatherCellView alloc] initWithDayDictionary:day andFrame:CGRectMake(xOrigin, 0, 40.0f, WEATHER_CELL_HEIGHT - (WRAPPER_OFFSET_VERTICAL * 2))];
        [_scroller addSubview:dayOfWeek];
        xOrigin += 40.0f;
    }
    
    [_scroller setContentSize:CGSizeMake(xOrigin, WEATHER_CELL_HEIGHT - (WRAPPER_OFFSET_VERTICAL * 2))];

    [self addSubview:_scroller];
}

@end
