//
//  OMUSideMenu.h
//  Oh_My_UW
//
//  Created by Eric Lui on 2013-05-30.
//  Copyright (c) 2013 Eric Lui. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OMUSideMenuHeader.h"

@protocol OMUSideMenuDelegate;

typedef enum sectionType {
    sectionTypeHome = 0,
    sectionTypeSchool,
    sectionTypeDirection,
    sectionTypeSocial,
    sectionTypeOther,
    numberOfCellType
} sectionType;

@interface OMUSideMenu : UIView <UITableViewDataSource, UITableViewDelegate, OMUSideMenuHeaderDelegate> {
    UITableView * _menu;
    NSInteger _openSectionIndex;
}

@property (nonatomic, strong) id <OMUSideMenuDelegate> delegate;

+ (NSArray * const) sectionRowTitles;

@end

@protocol OMUSideMenuDelegate <NSObject>

@optional
- (void) popAllControllersAndPush:(UIViewController *) controller;
- (void) popAllControllersToRoot;

@end
