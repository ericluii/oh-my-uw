//
//  OMUSideMenuHeader.h
//  Oh_My_UW
//
//  Created by Eric Lui on 2013-06-26.
//  Copyright (c) 2013 Eric Lui. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol OMUSideMenuHeaderDelegate;

@interface OMUSideMenuHeader : UITableViewHeaderFooterView {
    UILabel * _titleLabel;
    BOOL _expanded;
}

@property (nonatomic, strong) id <OMUSideMenuHeaderDelegate> delegate;
@property (nonatomic) NSInteger section;

- (id)initWithTitle:(NSString *) title andImageNamed:(NSString *) imageNamed;
+ (NSString *) reuseIdentifier;
+ (CGFloat) heightForHeader;

@end

@protocol OMUSideMenuHeaderDelegate <NSObject>

@optional
-(void)sectionHeaderView:(OMUSideMenuHeader *)sectionHeaderView sectionOpened:(NSInteger)section;
-(void)sectionHeaderView:(OMUSideMenuHeader *)sectionHeaderView sectionClosed:(NSInteger)section;

@end