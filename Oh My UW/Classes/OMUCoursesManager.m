//
//  OMUCoursesManager.m
//  Oh_My_UW
//
//  Created by Eric Lui on 2013-06-08.
//  Copyright (c) 2013 Eric Lui. All rights reserved.
//

#import "OMUCoursesManager.h"
#import "AFJSONRequestOperation.h"
#import "OMURequestConstants.h"
#import "OMUExamScheduleCourse.h"
#import "OMUDepartment.h"

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

#pragma mark - Profile Methods

- (void) restoreCourses {
    
}

- (void) saveCourses {
    
}

- (BOOL) currentlyAtSchool {
    return YES;
}

#pragma mark - Request Methods

- (void) getExamSchedule {
    NSURLRequest *request = [NSURLRequest requestWithURL:[OMURequestConstants examScheduleURL]];
    AFJSONRequestOperation *operation = [AFJSONRequestOperation JSONRequestOperationWithRequest:request success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {
        NSLog(@"Exam Schedule Successfully Fetched");
        
        _examScheduleTerm = [[[JSON objectForKey:@"response"] objectForKey:@"data"] objectForKey:@"Term"];
        _examScheduleArray = [NSMutableArray array];
        for (NSDictionary * result in [[[JSON objectForKey:@"response"] objectForKey:@"data"] objectForKey:@"result"]) {
            OMUExamScheduleCourse * course = [[OMUExamScheduleCourse alloc] init];
            [course configureWithJSONResponse:result];
            [_examScheduleArray addObject:course];
        }
   
        if ([_delegate respondsToSelector:@selector(OMUCoursesManagerCompletedRequestWithSuccess:)]) {
            [_delegate OMUCoursesManagerCompletedRequestWithSuccess:@{@"term":_examScheduleTerm, @"courses":_examScheduleArray}];
        }
    } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id JSON) {
        NSLog(@"Exam Schedule Failed to Fetch: %@", error);
        if ([_delegate respondsToSelector:@selector(OMUCoursesManagerCompletedRequestWithError:)]) {
            [_delegate OMUCoursesManagerCompletedRequestWithError:error];
        }
    }];
    
    [operation start];
}

- (void) getDepartments {
    if (_departmentArray) {
        if ([_delegate respondsToSelector:@selector(OMUCoursesManagerCompletedRequestWithSuccess:)]) {
            [_delegate OMUCoursesManagerCompletedRequestWithSuccess:_departmentArray];
        }
        
        return;
    }
    
    NSURLRequest *request = [NSURLRequest requestWithURL:[OMURequestConstants departmentURL]];
    AFJSONRequestOperation *operation = [AFJSONRequestOperation JSONRequestOperationWithRequest:request success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {
        NSLog(@"Departments List Successfully Fetched");
        
        NSMutableSet * uniqueDepartments = [NSMutableSet set];
        
        _departmentArray = [NSMutableArray array];
        for (NSDictionary * result in [[[JSON objectForKey:@"response"] objectForKey:@"data"] objectForKey:@"result"]) {
            OMUDepartment * department = [[OMUDepartment alloc] init];
            [department configureWithJSONResponse:result];
            if (![uniqueDepartments containsObject:[NSString stringWithFormat:@"%@ - %@", department.acronym, department.name]]) {
                [_departmentArray addObject:department];
                [uniqueDepartments addObject:[NSString stringWithFormat:@"%@ - %@", department.acronym, department.name]];
            }
        }
        
        NSSortDescriptor *descriptor = [[NSSortDescriptor alloc] initWithKey:@"acronym" ascending:YES];
        [_departmentArray sortUsingDescriptors:@[descriptor]];
        
        if ([_delegate respondsToSelector:@selector(OMUCoursesManagerCompletedRequestWithSuccess:)]) {
            [_delegate OMUCoursesManagerCompletedRequestWithSuccess:_departmentArray];
        }
    } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id JSON) {
        NSLog(@"Departments List Failed to Fetch: %@", error);
        if ([_delegate respondsToSelector:@selector(OMUCoursesManagerCompletedRequestWithError:)]) {
            [_delegate OMUCoursesManagerCompletedRequestWithError:error];
        }
    }];
    
    [operation start];
}

@end
