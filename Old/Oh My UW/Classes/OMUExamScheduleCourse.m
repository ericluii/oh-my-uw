//
//  OMUExamScheduleCourse.m
//  Oh_My_UW
//
//  Created by Eric Lui on 2013-07-26.
//  Copyright (c) 2013 Eric Lui. All rights reserved.
//

#import "OMUExamScheduleCourse.h"

@implementation OMUExamScheduleCourse

- (id) init {
    self = [super init];
    if (self) {
    }
    return self;
}

- (void) configureWithJSONResponse:(NSDictionary *) response {
    NSDateFormatter * formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"M d, y"];

    _identifier = [response objectForKey:@"ID"];
    _term = [response objectForKey:@"Term"];
    _course = [response objectForKey:@"Course"];
    _section = [response objectForKey:@"Section"];
    _day = [response objectForKey:@"Day"];
    _date = [formatter dateFromString:[response objectForKey:@"Date"]];
    _startTime = [response objectForKey:@"Start"];
    _endTime = [response objectForKey:@"End"];
    _Location = [response objectForKey:@"Location"];
}

@end
