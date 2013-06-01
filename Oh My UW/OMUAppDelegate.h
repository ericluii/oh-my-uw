//
//  OMUAppDelegate.h
//  Oh My UW
//
//  Created by Eric Lui on 2013-05-17.
//  Copyright (c) 2013 Eric Lui. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OMUNavigationBar.h"
#import "OMUSideMenu.h"

@class OMUDefaultViewController;

@interface OMUAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) OMUDefaultViewController *viewController;
@property (strong, nonatomic) UINavigationController * navigator;

@end
