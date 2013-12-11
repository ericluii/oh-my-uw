//
//  SideMenuView.m
//  UWPortal
//
//  Created by Eric Lui on 12/10/2013.
//  Copyright (c) 2013 Eric Lui. All rights reserved.
//

#import "SideMenuView.h"

@implementation SideMenuView

- (id)initWithMenuDelegate:(id) delegate {
    self = [super initWithFrame:CGRectMake(0,
                                           0,
                                           CGRectGetWidth([[UIScreen mainScreen] bounds]) - 60,
                                           CGRectGetHeight([[UIScreen mainScreen] bounds]))];
    if (self) {
        // Initialization code
        _menu = [[UITableView alloc] initWithFrame:self.frame];
        [_menu setBackgroundColor:[UIColor clearColor]];
        [_menu setDelegate:delegate];
        [_menu setDataSource:delegate];
        [self addSubview:_menu];
        [self setBackgroundColor:[UIColor clearColor]];
        
        // Add frost effect
        UIToolbar *toolbar = [[UIToolbar alloc] initWithFrame:self.frame];
        toolbar.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        toolbar.barTintColor = self.tintColor;
        [self insertSubview:toolbar atIndex:0];
    }
    return self;
}



+ (NSArray * const) sectionHeaderTitles {
    static NSArray *sectionHeaderTitles = nil;
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        sectionHeaderTitles = @[@"Home",
                                @"School Organizer",
                                @"Directions",
                                @"Social Feeds",
                                @"Other Stuff"];
    });
    
    return sectionHeaderTitles;
}

+ (NSArray * const) sectionRowTitles {
    static NSArray *sectionRowTitles = nil;
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        sectionRowTitles = @[@[],
                             @[@"Courses", @"Exam Schedule"], // @"School Planner",  @"UW Learn", @"Jobmine", @"Quest", @"Assignments", @"Midterms",
                             @[@"Campus", @"Food", @"Study Spots", @"Parking"], // @"Around the City"
                             @[@"Suggestions", @"About the App"],
                             @[@"Reddit UW", @"Twitter", @"Goose Watch", @"Events"]]; // News
    });
    
    return sectionRowTitles;
}

@end
