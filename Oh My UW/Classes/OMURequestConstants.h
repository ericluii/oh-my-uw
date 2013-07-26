//
//  OMURequestConstants.h
//  Oh_My_UW
//
//  Created by Eric Lui on 2013-06-07.
//  Copyright (c) 2013 Eric Lui. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OMURequestConstants : NSObject

@property (nonatomic, strong) NSMutableDictionary * imageCache;

+ (NSURL *) examScheduleURL;
+ (NSURL *) weatherURL;
+ (OMURequestConstants *) sharedInstance;

@end
