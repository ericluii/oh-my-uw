//
//  OMUCoursesManager.h
//  Oh_My_UW
//
//  Created by Eric Lui on 2013-06-08.
//  Copyright (c) 2013 Eric Lui. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol OMUCoursesManagerDelegate <NSObject>

@optional
- (void) OMUCoursesManagerCompletedRequestWithSuccess:(id) result;
- (void) OMUCoursesManagerCompletedRequestWithError:(NSError *) error;

@end

@interface OMUCoursesManager : NSObject {
    NSMutableArray * _departmentArray;
    
    NSMutableArray * _examScheduleArray;
    NSString * _examScheduleTerm;
}

@property (nonatomic, strong) id<OMUCoursesManagerDelegate> delegate;

+ (OMUCoursesManager *) sharedInstance;

// Profile Methods
- (void) restoreCourses;
- (void) saveCourses;
- (BOOL) currentlyAtSchool;

// Request Methods
- (void) getExamSchedule;
- (void) getDepartments;

@end
