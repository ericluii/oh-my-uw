//
//  OMUCoursesManager.m
//  Oh_My_UW
//
//  Created by Eric Lui on 2013-06-08.
//  Copyright (c) 2013 Eric Lui. All rights reserved.
//

#import "OMUCoursesManager.h"

NSString * const coursesLocalFileName = @"OMUCoursesLocalSaveFile";

@implementation OMUCoursesManager

+ (OMUCoursesManager *) sharedInstance {
    static OMUCoursesManager * sharedInstance;
    static dispatch_once_t oncePredicate;
    dispatch_once(&oncePredicate, ^{
        sharedInstance = [[self alloc] init];
    });
    return sharedInstance;
}

- (void) restoreCourses {
    
}

- (void) saveCourses {
    
}

- (BOOL) currentlyAtSchool {
    return YES;
}

@end
