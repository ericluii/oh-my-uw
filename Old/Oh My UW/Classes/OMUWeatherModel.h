//
//  OMUWeatherModel.h
//  Oh_My_UW
//
//  Created by Eric Lui on 2013-06-08.
//  Copyright (c) 2013 Eric Lui. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OMUWeatherModel : NSObject

@property (nonatomic, strong) NSString * condition;
@property (nonatomic, strong) NSDate * lastUpdated;
@property (nonatomic, strong) NSDate * lastRecorded;
@property (nonatomic) double temperatureHigh;
@property (nonatomic) double temperatureLow;
@property (nonatomic) double temperatureCurrent;
@property (nonatomic) double humidity;
@property (nonatomic) double windSpeed;
@property (nonatomic, strong) NSString * windDirection;
@property (nonatomic, strong) NSArray * restOfWeek;
@property (nonatomic, strong) NSString * imageUrl;

+ (OMUWeatherModel *) sharedInstance;
- (void) configureWithJSONResponse:(NSDictionary *) response;

@end
