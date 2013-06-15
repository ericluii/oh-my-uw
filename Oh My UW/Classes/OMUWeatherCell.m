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
#import "OMUDefaultCellWrapper.h"
#import "OMUMinorWeatherCellView.h"

@implementation OMUWeatherCell

- (id)initWithWeather:(OMUWeatherModel *) weather {
    self = [super initWithFrame:CGRectMake(0.0f, 0.0f, 320.0f, WEATHER_CELL_HEIGHT)];
    if (self) {
        // Initialization code
        _weather = weather;
        [self setSelectionStyle:UITableViewCellSelectionStyleNone];
        [self configure];
    }
    return self;
}

+ (NSString *) reuseIdentifier {
    return @"OMUWeatherCellReuseID";
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void) configure {
    _wrapper = [[OMUDefaultCellWrapper alloc] initWithFrame:CGRectMake(WRAPPER_OFFSET_HORIZONTAL, WRAPPER_OFFSET_VERTICAL, 320.0f - (WRAPPER_OFFSET_HORIZONTAL * 2), WEATHER_CELL_HEIGHT - (WRAPPER_OFFSET_VERTICAL * 2))];
    
    _scroller = [[UIScrollView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 320.0f - (WRAPPER_OFFSET_HORIZONTAL * 2), WEATHER_CELL_HEIGHT - (WRAPPER_OFFSET_VERTICAL * 2))];
    [_scroller setDelegate:self];
    [_scroller setScrollEnabled:YES];
    
    _mainWeatherView = [[OMUMainWeatherCellView alloc] initWithWeather: _weather];
    [_scroller addSubview:_mainWeatherView];
    
    CGFloat xOrigin = _mainWeatherView.frame.size.width + 7.0f;
    for (NSDictionary *day in _weather.restOfWeek) {
        OMUMinorWeatherCellView * dayOfWeek = [[OMUMinorWeatherCellView alloc] initWithDayDictionary:day andFrame:CGRectMake(xOrigin, 0, 40.0f, WEATHER_CELL_HEIGHT - (WRAPPER_OFFSET_VERTICAL * 2))];
        [_scroller addSubview:dayOfWeek];
        xOrigin += 40.0f;
    }
    
    [_scroller setContentSize:CGSizeMake(xOrigin, WEATHER_CELL_HEIGHT - (WRAPPER_OFFSET_VERTICAL * 2))];
    
    [_wrapper addSubview:_scroller];
    [self addSubview:_wrapper];
}

@end
