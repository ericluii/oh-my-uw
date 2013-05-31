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
    BOOL _menuExpanded;
}

@property (nonatomic, strong) UINavigationController * navigator;


- (id)initWithRootViewController:(UIViewController *)rootViewController;

@end
