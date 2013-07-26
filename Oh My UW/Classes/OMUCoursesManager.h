//
//  OMUCoursesManager.h
//  Oh_My_UW
//
//  Created by Eric Lui on 2013-06-08.
//  Copyright (c) 2013 Eric Lui. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OMUCoursesManager : NSObject

+ (OMUCoursesManager *) sharedInstance;
- (void) getAllCourses;
- (void) restoreCourses;
- (void) saveCourses;
- (BOOL) currentlyAtSchool;

@end
