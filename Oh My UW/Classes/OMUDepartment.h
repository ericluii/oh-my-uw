//
//  OMUDepartment.h
//  Oh_My_UW
//
//  Created by Eric Lui on 2013-07-27.
//  Copyright (c) 2013 Eric Lui. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OMUDepartment : NSObject

@property (nonatomic, strong) NSString * identifier;
@property (nonatomic, strong) NSString * acronym;
@property (nonatomic, strong) NSString * name;
@property (nonatomic, strong) NSString * faculty;
@property (nonatomic, strong) NSString * courseURL;
@property (nonatomic, strong) NSString * type;

- (void) configureWithJSONResponse:(NSDictionary *) response;

@end
