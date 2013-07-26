//
//  OMUExamScheduleCourse.h
//  Oh_My_UW
//
//  Created by Eric Lui on 2013-07-26.
//  Copyright (c) 2013 Eric Lui. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OMUExamScheduleCourse : NSObject

@property (nonatomic, strong) NSString * identifier;
@property (nonatomic, strong) NSString * term;
@property (nonatomic, strong) NSString * course;
@property (nonatomic, strong) NSString * section;
@property (nonatomic, strong) NSString * day;
@property (nonatomic, strong) NSDate * date;
@property (nonatomic, strong) NSString * startTime;
@property (nonatomic, strong) NSString * endTime;
@property (nonatomic, strong) NSString * Location;

- (void) configureWithJSONResponse:(NSDictionary *) response;

@end