//
//  OMUMainWeatherCellView.m
//  Oh_My_UW
//
//  Created by Eric Lui on 2013-06-08.
//  Copyright (c) 2013 Eric Lui. All rights reserved.
//

#import "OMUMainWeatherCellView.h"
#import "OMUWeatherModel.h"
#import "OMUNavigationConstants.h"
#import "AFImageRequestOperation.h"
#import "OMURequestConstants.h"

@implementation OMUMainWeatherCellView

- (id)initWithWeather:(OMUWeatherModel *) weather {
    self = [super initWithFrame: CGRectMake(0, 0, 200.0f, WEATHER_CELL_HEIGHT)];
    if (self) {
        // Initialization code
        _weather = weather;
        [self setupMainImage];
        [self setupCondition];
        [self setupTempature];
        [self setupHighLow];
        [self setupRightMargin];
    }
    return self;
}

- (void) setupMainImage {
    _mainWeatherImage = [[UIImageView alloc] initWithFrame:CGRectMake(5.0f, 10.0f, 60.0f, 51.0f)];
    [self addSubview:_mainWeatherImage];
    [self fetchImage];
}

- (void) setupCondition {
    _conditionLbl = [[UILabel alloc] initWithFrame:CGRectMake(83.0f, 7.0f, 130.0f, 20.0f)];
    [_conditionLbl setText:_weather.condition];
    [_conditionLbl setTextColor:[UIColor lightGrayColor]];
    [self addSubview:_conditionLbl];
}

- (void) setupTempature {
    _currentTemperatureLbl = [[UILabel alloc] initWithFrame:CGRectMake(80.0f, 20.0f, 110.0f, 44.0f)];
    [_currentTemperatureLbl setText:[NSString stringWithFormat:@"%.1f°C", _weather.temperatureCurrent]];
    [_currentTemperatureLbl setBackgroundColor:[UIColor clearColor]];
    [_currentTemperatureLbl setFont:[UIFont systemFontOfSize:35.0f]];
    [_currentTemperatureLbl setTextColor:[UIColor grayColor]];
    [self addSubview:_currentTemperatureLbl];
}

- (void) setupHighLow {
    _rangeTemperatureLbl = [[UILabel alloc] initWithFrame:CGRectMake(5.0f, 57.0f, 200.0f, 20.0f)];
    [_rangeTemperatureLbl setTextColor:[UIColor lightGrayColor]];
    [_rangeTemperatureLbl setText:[NSString stringWithFormat:@"%.1f°C - %.1f°C | Wind: %.1f km/h %@",
                                   _weather.temperatureLow,
                                   _weather.temperatureHigh,
                                   _weather.windSpeed,
                                   _weather.windDirection]];
    [_rangeTemperatureLbl setFont:[UIFont systemFontOfSize:12.0f]];
    [self addSubview:_rangeTemperatureLbl];
}

- (void) setupRightMargin {
    UIView *rightBorder = [[UIView alloc] initWithFrame:CGRectMake(205.0f, 5.0f, 1.0f, WEATHER_CELL_HEIGHT - 20.0f)];
    [rightBorder setBackgroundColor:[UIColor yellowColor]];
    [self addSubview:rightBorder];
}

- (void) fetchImage {
    UIImage * img = [[[OMURequestConstants sharedInstance] imageCache] objectForKey:_weather.imageUrl];
    
    if (img) {
        [_mainWeatherImage setImage:img];
    } else {
        NSURLRequest * request = [[NSURLRequest alloc] initWithURL:[NSURL URLWithString:_weather.imageUrl]];
        AFImageRequestOperation * operation = [AFImageRequestOperation imageRequestOperationWithRequest:request success:^(UIImage *image) {
            [[[OMURequestConstants sharedInstance] imageCache] setObject:image forKey:_weather.imageUrl];
            [_mainWeatherImage setImage:image];
        }];
        [operation start];
    }
}

@end
