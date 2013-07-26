//
//  OMURequestConstants.m
//  Oh_My_UW
//
//  Created by Eric Lui on 2013-06-07.
//  Copyright (c) 2013 Eric Lui. All rights reserved.
//

#import "OMURequestConstants.h"

NSString const * API_TOKEN = @"YOUR_API_TOKEN";
NSString const * BASE_URL = @"http://api.uwaterloo.ca/public/v1/";

@implementation OMURequestConstants

- (id) init {
    self = [super init];
    
    if (self) {
        _imageCache = [[NSMutableDictionary alloc] init];
    }
    
    return self;
}

+ (OMURequestConstants *) sharedInstance {
    static OMURequestConstants * sharedInstance;
    static dispatch_once_t oncePredicate;
    
    dispatch_once(&oncePredicate, ^{
        sharedInstance = [[self alloc] init];
    });
    
    return sharedInstance;
}

+ (NSURL *) weatherURL {
    return [NSURL URLWithString:[NSString stringWithFormat:@"%@?key=%@&service=Weather&output=json", BASE_URL, API_TOKEN]];
}

+ (NSURL *) examScheduleURL {
    return [NSURL URLWithString:[NSString stringWithFormat:@"%@?key=%@&service=ExamSchedule&output=json", BASE_URL, API_TOKEN]];
}

@end