//
//  OMUMinorWeatherCellView.m
//  Oh_My_UW
//
//  Created by Eric Lui on 2013-06-08.
//  Copyright (c) 2013 Eric Lui. All rights reserved.
//

#import "OMUMinorWeatherCellView.h"
#import "AFImageRequestOperation.h"
#import "OMURequestConstants.h"

@implementation OMUMinorWeatherCellView

- (id)initWithDayDictionary:(NSDictionary *) dayDict andFrame:(CGRect) frame {
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        _dayDict = dayDict;
        [self setupMainImage];
        [self setupDay];
        [self setupHigh];
        [self setupLow];
    }
    return self;
}

- (void) setupDay {
    _dayLbl = [[UILabel alloc] initWithFrame:CGRectMake(0, 7.0f, self.frame.size.width, 20.0f)];
    [_dayLbl setTextAlignment:NSTextAlignmentCenter];
    [_dayLbl setText:[[_dayDict objectForKey:@"Day"] substringToIndex:3]];
    [_dayLbl setTextColor:[UIColor lightGrayColor]];
    [_dayLbl setFont:[UIFont systemFontOfSize:12.0f]];
    [_dayLbl setBackgroundColor:[UIColor clearColor]];
    [self addSubview:_dayLbl];
}

- (void) setupMainImage {
    _mainWeatherImage = [[UIImageView alloc] initWithFrame:CGRectMake(floor((self.frame.size.width - 30.0f)/2), 25.0f, 30.0f, 26.0f)];
    [self addSubview:_mainWeatherImage];
    [self fetchImage];
}

- (void) setupHigh {
    _highTemperatureLbl = [[UILabel alloc] initWithFrame:CGRectMake(0, 48.0f, self.frame.size.width, 20.0f)];
    [_highTemperatureLbl setTextAlignment:NSTextAlignmentCenter];
    [_highTemperatureLbl setTextColor:[UIColor grayColor]];
    [_highTemperatureLbl setFont:[UIFont systemFontOfSize:10.0f]];
    [_highTemperatureLbl setBackgroundColor:[UIColor clearColor]];
    [_highTemperatureLbl setText:[_dayDict objectForKey:@"High"]];
    [self addSubview:_highTemperatureLbl];
}

- (void) setupLow {
    _lowTemperatureLbl = [[UILabel alloc] initWithFrame:CGRectMake(0, 58.0f, self.frame.size.width, 20.0f)];
    [_lowTemperatureLbl setTextAlignment:NSTextAlignmentCenter];
    [_lowTemperatureLbl setTextColor:[UIColor lightGrayColor]];
    [_lowTemperatureLbl setFont:[UIFont systemFontOfSize:10.0f]];
    [_lowTemperatureLbl setBackgroundColor:[UIColor clearColor]];
    [_lowTemperatureLbl setText:[_dayDict objectForKey:@"Low"]];
    [self addSubview:_lowTemperatureLbl];
}

- (void) fetchImage {
    NSString * url = [_dayDict objectForKey:@"Image"];
    UIImage * img = [[[OMURequestConstants sharedInstance] imageCache] objectForKey:url];
    
    if (img) {
        [_mainWeatherImage setImage:img];
    } else {
        NSURLRequest * request = [[NSURLRequest alloc] initWithURL:[NSURL URLWithString:url]];
        AFImageRequestOperation * operation = [AFImageRequestOperation imageRequestOperationWithRequest:request success:^(UIImage *image) {
            [[[OMURequestConstants sharedInstance] imageCache] setObject:image forKey:url];
            [_mainWeatherImage setImage:image];
        }];
        [operation start];
    }
}
@end
