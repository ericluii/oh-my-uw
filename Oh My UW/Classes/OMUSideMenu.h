//
//  OMUSideMenu.h
//  Oh_My_UW
//
//  Created by Eric Lui on 2013-05-30.
//  Copyright (c) 2013 Eric Lui. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OMUSideMenuHeader.h"

typedef enum sectionType {
    sectionTypeSchool = 0,
    sectionTypeDirection,
    sectionTypeSocial,
    sectionTypeOther,
    numberOfCellType
} sectionType;

@interface OMUSideMenu : UIView <UITableViewDataSource, UITableViewDelegate, OMUSideMenuHeaderDelegate> {
    UITableView * _menu;
    NSInteger _openSectionIndex;
}

+ (NSArray * const) sectionRowTitles;

@end
