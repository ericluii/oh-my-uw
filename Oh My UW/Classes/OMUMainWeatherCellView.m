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
    }
    return self;
}

- (void) drawRect:(CGRect)rect {
    [[UIColor lightGrayColor] set];
    [_weather.condition drawInRect:CGRectMake(83.0f, 7.0f, 130.0f, 20.0f)
                          withFont:[UIFont systemFontOfSize:12.0f]
                     lineBreakMode:NSLineBreakByClipping];
    
    [_weather.condition drawInRect:CGRectMake(5.0f, 57.0f, 200.0f, 20.0f)
                          withFont:[UIFont systemFontOfSize:12.0f]
                     lineBreakMode:NSLineBreakByClipping];
    
    [[UIColor grayColor] set];
    [[NSString stringWithFormat:@"%.1f°C - %.1f°C | Wind: %.1f km/h %@",
                                _weather.temperatureLow,
                                  _weather.temperatureHigh,
                                  _weather.windSpeed,
                                  _weather.windDirection]
                                         drawInRect:CGRectMake(5.0f, 57.0f, 200.0f, 20.0f)
                                           withFont:[UIFont systemFontOfSize:12.0f]
                                      lineBreakMode:NSLineBreakByClipping];
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGRect divider = CGRectMake(205.0f, 5.0f, 1.0f, WEATHER_CELL_HEIGHT - 20.0f);
    CGContextAddRect(context, divider);
    CGContextSetFillColorWithColor(context, [UIColor yellowColor].CGColor);
    CGContextFillRect(context, divider);
}

- (void) setupMainImage {
    _mainWeatherImage = [[UIImageView alloc] initWithFrame:CGRectMake(5.0f, 10.0f, 60.0f, 51.0f)];
    [self addSubview:_mainWeatherImage];
    [self fetchImage];
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
