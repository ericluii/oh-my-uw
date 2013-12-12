//
//  SideMenuView.h
//  UWPortal
//
//  Created by Eric Lui on 12/10/2013.
//  Copyright (c) 2013 Eric Lui. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SideMenuView : UIView <UITableViewDelegate, UITableViewDataSource> {
    UIViewController * _ownerViewController;
    BOOL _isShowing;
}

typedef enum SectionType {
    sectionTypeSchool = 0,
    sectionTypeDirection,
    sectionTypeOther,
    numberOfCellType,
    sectionTypeSocial
} SectionType;

@property(nonatomic, strong) UITableView * menu;
@property(nonatomic, strong) UIImageView * blurBackground;
@property(nonatomic, strong) UIView * blockingView;

- (id)initWithViewController:(UIViewController*)vc;
- (void) panHandler:(UIPanGestureRecognizer *) recognizer;

+ (NSArray * const) sectionHeaderTitles;
+ (NSArray * const) sectionRowTitles;

@end
