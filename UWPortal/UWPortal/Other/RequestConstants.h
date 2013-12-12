//
//  RequestConstants.h
//  Oh_My_UW
//
//  Created by Eric Lui on 2013-06-07.
//  Copyright (c) 2013 Eric Lui. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RequestConstants : NSObject

@property (nonatomic, strong) NSMutableDictionary * imageCache;

+ (NSURL *) departmentURL;
+ (NSURL *) examScheduleURL;
+ (NSURL *) weatherURL;
+ (RequestConstants *) sharedInstance;

@end
