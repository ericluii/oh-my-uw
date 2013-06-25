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
    self = [super initWithFrame: CGRectMake(0, 0, 216.0f, WEATHER_CELL_HEIGHT)];
    if (self) {
        // Initialization code
        _weather = weather;
        [self setBackgroundColor:[UIColor whiteColor]];
        [self setup];
        [self setupDrawConstants];
    }
    return self;
}

- (void) drawRect:(CGRect)rect {
    [[UIColor lightGrayColor] set];
    [_weather.condition drawInRect:_conditionFrame
                          withFont:_smallFont
                     lineBreakMode:NSLineBreakByClipping];
    
    [_currentTemperatureText drawInRect:_currentTempFrame
                          withFont:_largeFont
                     lineBreakMode:NSLineBreakByClipping];
    
    [[UIColor grayColor] set];
    [_summaryText drawInRect:_summaryFrame
                    withFont:_smallFont
               lineBreakMode:NSLineBreakByClipping];
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextAddRect(context, _dividerFrame);
    CGContextSetFillColorWithColor(context, [UIColor yellowColor].CGColor);
    CGContextFillRect(context, _dividerFrame);
}

- (void) setup {
    _currentTemperatureText = [NSString stringWithFormat:@"%.1f°C", _weather.temperatureCurrent];
    
    _summaryText = [NSString stringWithFormat:@"%.1f°C - %.1f°C | Wind: %.1f km/h %@",
                                     _weather.temperatureLow,
                                     _weather.temperatureHigh,
                                     _weather.windSpeed,
                                     _weather.windDirection];
    
    _mainWeatherImage = [[UIImageView alloc] initWithFrame:CGRectMake(7.0f, 10.0f, 60.0f, 51.0f)];
    [self addSubview:_mainWeatherImage];
    [self fetchImage];
}

- (void) setupDrawConstants {
    _conditionFrame = CGRectMake(73.0f, 7.0f, 130.0f, 20.0f);
    _currentTempFrame = CGRectMake(70.0f, 20.0f, 110.0f, 44.0f);
    _summaryFrame = CGRectMake(12.0f, 63.0f, 200.0f, 20.0f);
    _dividerFrame = CGRectMake(215.0f, 7.0f, 1.0f, WEATHER_CELL_HEIGHT - 20.0f);
    
    _smallFont = [UIFont systemFontOfSize:12.0f];
    _largeFont = [UIFont systemFontOfSize:35.0f];
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
