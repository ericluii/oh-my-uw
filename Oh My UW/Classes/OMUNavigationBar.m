//
//  OMUNavigationBar.m
//  Oh_My_UW
//
//  Created by Eric Lui on 2013-05-28.
//  Copyright (c) 2013 Eric Lui. All rights reserved.
//

#import "OMUNavigationBar.h"
#import "OMUAppDelegate.h"
#import "OMUDeviceUtils.h"
#import "OMUImageManager.h"

@implementation OMUNavigationBar

- (id)initWithTitle:(NSString*) title {
    self = [super initWithFrame:CGRectMake(0, 0, 320, NAV_BAR_HEIGHT + ([OMUDeviceUtils isIOS7] ? STATUS_BAR_HEIGHT : 0))];
    if (self) {
        // Initialization code
        _menuExpanded = false;
        _navigator = ((OMUAppDelegate *)[[UIApplication sharedApplication] delegate]).navigator;
        [self configureNavBarWithTitle:title];
    }
    return self;
}

- (void) configureNavBarWithTitle:(NSString *)title {
    [self setBackgroundColor:[UIColor colorWithRed:250/255.0 green:255/255.0 blue:82/255.0 alpha:1]];
    _background = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320.0f, NAV_BAR_HEIGHT + ([OMUDeviceUtils isIOS7] ? STATUS_BAR_HEIGHT : 0))];
    [_background setImage:[[OMUImageManager sharedInstance] getImageNamed:@"navbar_bg"]];
    
    _title = [[UILabel alloc] initWithFrame:CGRectMake(NAV_BAR_HEIGHT, [OMUDeviceUtils isIOS7] ? STATUS_BAR_HEIGHT : 0, 232, NAV_BAR_HEIGHT)];
    [_title setTextAlignment:NSTextAlignmentCenter];
    [_title setBackgroundColor:[UIColor clearColor]];
    [_title setTextColor:[UIColor lightGrayColor]];
    [_title setFont:[UIFont boldSystemFontOfSize:22]];
    [_title setText:title];
    
    _expandMenuBtn = [[UIButton alloc] initWithFrame:CGRectMake(2, 2 + ([OMUDeviceUtils isIOS7] ? STATUS_BAR_HEIGHT : 0), NAV_BAR_HEIGHT - 4, NAV_BAR_HEIGHT - 4)];
    [_expandMenuBtn setBackgroundImage:[[OMUImageManager sharedInstance] getImageNamed:@"navbar_menu_btn"] forState:UIControlStateNormal];
    [_expandMenuBtn addTarget:self action:@selector(switchMenuState) forControlEvents:UIControlEventTouchUpInside];
    
    _backBtn = [[UIButton alloc] initWithFrame:CGRectMake(2, 2 + ([OMUDeviceUtils isIOS7] ? STATUS_BAR_HEIGHT : 0), NAV_BAR_HEIGHT - 4, NAV_BAR_HEIGHT - 4)];
    [_backBtn setBackgroundImage:[[OMUImageManager sharedInstance] getImageNamed:@"main_image_school"] forState:UIControlStateNormal];
    [_backBtn addTarget:self action:@selector(backButtonPressed) forControlEvents:UIControlEventTouchUpInside];
    [_backBtn setHidden:YES];
    
    [self addSubview:_background];
    [self addSubview:_title];
    [self addSubview:_expandMenuBtn];
    [self addSubview:_backBtn];
}

- (void) switchMenuState {
    if (_menuExpanded) {
        [UIView animateWithDuration:0.4 animations:^{
            [[self superview] setFrame:CGRectMake(0, 0, [self superview].frame.size.width, [self superview].frame.size.height)];
        }];
    } else {
        [UIView animateWithDuration:0.4 animations:^{
            [[self superview] setFrame:CGRectMake(SIDE_MENU_WIDTH, 0, [self superview].frame.size.width, [self superview].frame.size.height)];
        }];
    }
    
    _menuExpanded = !_menuExpanded;
}

- (void) backButtonPressed {
    [_navigator popViewControllerAnimated:YES];
}

- (void) backButtonIsVisisble:(BOOL) visible {
    [_backBtn setHidden:!visible];
    [_expandMenuBtn setHidden:visible];
}

@end
