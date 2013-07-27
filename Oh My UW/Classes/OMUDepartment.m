//
//  OMUDepartment.m
//  Oh_My_UW
//
//  Created by Eric Lui on 2013-07-27.
//  Copyright (c) 2013 Eric Lui. All rights reserved.
//

#import "OMUDepartment.h"

@implementation OMUDepartment

- (id) init {
    self = [super init];
    if (self) {
    }
    return self;
}

- (void) configureWithJSONResponse:(NSDictionary *) response {
    _identifier = [response objectForKey:@"ID"];
    _name = [response objectForKey:@"Name"];
    _acronym = [response objectForKey:@"Acronym"];
    _faculty = [response objectForKey:@"Faculty"];
    _courseURL = [response objectForKey:@"CoursesURL"];
    _type = [response objectForKey:@"Type"];
}

@end
