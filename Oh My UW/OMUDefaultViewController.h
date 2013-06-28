//
//  OMUViewController.h
//  Oh My UW
//
//  Created by Eric Lui on 2013-05-17.
//  Copyright (c) 2013 Eric Lui. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OMUNavigationBar.h"
#import "OMUSideMenu.h"

@interface OMUDefaultViewController : UIViewController <OMUSideMenuDelegate> {
    OMUNavigationBar *_navBar;
    OMUSideMenu *_sideMenu;
    UIView *_contentView;
}

- (id) initWithTitle:(NSString *) title;
- (void) setBackButtonVisible:(bool) isVisible;
- (void) pushViewController:(UIViewController *) controller;
+(CGRect)viewFrame;

@end
