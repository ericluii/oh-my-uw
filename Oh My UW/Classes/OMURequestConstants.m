//
//  OMURequestConstants.m
//  Oh_My_UW
//
//  Created by Eric Lui on 2013-06-07.
//  Copyright (c) 2013 Eric Lui. All rights reserved.
//

#import "OMURequestConstants.h"

NSString const * API_TOKEN = @"52a604ab3d115f1f65802d68414b6a64";
NSString const * BASE_URL = @"http://api.uwaterloo.ca/public/v1/";

@implementation OMURequestConstants

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

@end