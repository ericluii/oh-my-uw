//
//  SideMenuView.h
//  UWPortal
//
//  Created by Eric Lui on 12/10/2013.
//  Copyright (c) 2013 Eric Lui. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SideMenuView : UIView

typedef enum sectionType {
    sectionTypeHome = 0,
    sectionTypeSchool,
    sectionTypeDirection,
    sectionTypeSocial,
    sectionTypeOther,
    numberOfCellType
} sectionType;

@property(nonatomic, strong) UITableView * menu;
@property(nonatomic, strong) UIImageView * blurBackground;

- (id)initWithMenuDelegate:(id) delegate;
- (void) panHandler:(UIPanGestureRecognizer *) recognizer;

+ (NSArray * const) sectionHeaderTitles;
+ (NSArray * const) sectionRowTitles;

@end
