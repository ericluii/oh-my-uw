//
//  SideMenuHeaderView.h
//  UWPortal
//
//  Created by Eric Lui on 12/11/2013.
//  Copyright (c) 2013 Eric Lui. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SideMenuHeaderViewDelegate;

@interface SideMenuHeaderView : UITableViewHeaderFooterView {
    BOOL _isOpen;
}

@property (nonatomic, strong) id <SideMenuHeaderViewDelegate> delegate;
@property (nonatomic) NSInteger section;

- (id)initWithSectionNumber:(NSInteger)sectionNumber;
- (void) toggleOpenState;
+ (NSInteger)headerHeight;
+ (NSString*)reuseIdentifier;

@end

// Delegate for tapping a header

@protocol SideMenuHeaderViewDelegate <NSObject>

-(void)sectionHeaderView:(SideMenuHeaderView *)sectionHeaderView sectionOpened:(NSInteger)section;
-(void)sectionHeaderView:(SideMenuHeaderView *)sectionHeaderView sectionClosed:(NSInteger)section;

@end