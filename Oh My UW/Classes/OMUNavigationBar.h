//
//  OMUNavigationBar.h
//  Oh_My_UW
//
//  Created by Eric Lui on 2013-05-28.
//  Copyright (c) 2013 Eric Lui. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OMUNavigationBar : UIView {
    UILabel * _title;
    UIButton * _expandMenuBtn;
}

@property (nonatomic, strong) UINavigationController * navigator;
@property (nonatomic) BOOL menuExpanded;


- (id)initWithTitle:(NSString*) title;
- (void) pushViewController:(UIViewController *) vc animated:(BOOL) animate;
- (void) popViewControllerAndAnimated:(BOOL) animate;
- (void) toggleHidden:(BOOL)hide;
@end
