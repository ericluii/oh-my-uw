//
//  AppDelegate.h
//  UWPortal
//
//  Created by Eric Lui on 12/10/2013.
//  Copyright (c) 2013 Eric Lui. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HomeViewController.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) UINavigationController * navigator;
@property (strong, nonatomic) UIViewController * rootViewController;

+ (AppDelegate *) appDelegate;

@end
