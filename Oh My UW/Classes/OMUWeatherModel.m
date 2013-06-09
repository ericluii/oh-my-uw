//
//  OMUWeatherModel.m
//  Oh_My_UW
//
//  Created by Eric Lui on 2013-06-08.
//  Copyright (c) 2013 Eric Lui. All rights reserved.
//

#import "OMUWeatherModel.h"

@implementation OMUWeatherModel

- (id) init {
    self = [super init];
    if (self) {
        
    }
    return self;
}

+ (OMUWeatherModel *) sharedInstance {
    static OMUWeatherModel *sharedInstance = nil;
    static dispatch_once_t oncePredicate;
    dispatch_once(&oncePredicate, ^{
        sharedInstance = [[self alloc] init];
    });
    return sharedInstance;
}

- (void) configureWithJSONResponse:(NSDictionary *) response {
    _condition = [[response objectForKey:@"Current"] objectForKey:@"Condition"];
    _lastUpdated = [response objectForKey:@"Date"];
    _lastRecorded = [[response objectForKey:@"Current"] objectForKey:@"AsOf"];
    _temperatureCurrent = [[[response objectForKey:@"Current"] objectForKey:@"Temp"] doubleValue];
    _temperatureHigh = [[[response objectForKey:@"Current"] objectForKey:@"Max"] doubleValue];
    _temperatureLow = [[[response objectForKey:@"Current"] objectForKey:@"Min"] doubleValue];
    _humidity = [[[response objectForKey:@"Current"] objectForKey:@"Humidity"] doubleValue];
    _windSpeed = [[[response objectForKey:@"Current"] objectForKey:@"Wind"] doubleValue];
    _windDirection = [[response objectForKey:@"Current"] objectForKey:@"WindDir"];
    _imageUrl = [[response objectForKey:@"Current"] objectForKey:@"Icon"];
    _restOfWeek = [[response objectForKey:@"Week"] objectForKey:@"result"];
}

@end
