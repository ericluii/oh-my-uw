//
//  OMUNavigationBar.m
//  Oh_My_UW
//
//  Created by Eric Lui on 2013-05-28.
//  Copyright (c) 2013 Eric Lui. All rights reserved.
//

#import "OMUNavigationBar.h"

@implementation OMUNavigationBar

- (id)initWithRootViewController:(UIViewController *)rootViewController {
    self = [super initWithFrame:CGRectMake(0, 0, 320, 44)];
    if (self) {
        // Initialization code
        _menuExpanded = false;
        _navigator = [[UINavigationController alloc] initWithRootViewController:rootViewController];
        [_navigator setNavigationBarHidden:YES];
        [self styleNavBar];
    }
    return self;
}

- (void) styleNavBar {
    [self setBackgroundColor:[UIColor colorWithRed:250/255.0 green:255/255.0 blue:82/255.0 alpha:1]];
    
    _title = [[UILabel alloc] initWithFrame:CGRectMake(44, 0, 232, 44)];
    [_title setTextAlignment:NSTextAlignmentCenter];
    [_title setBackgroundColor:[UIColor clearColor]];
    [_title setTextColor:[UIColor whiteColor]];
    [_title setShadowColor:[UIColor colorWithWhite:0.5 alpha:1]];
    [_title setShadowOffset:CGSizeMake(0, -1)];
    [_title setFont:[UIFont boldSystemFontOfSize:22]];
    [_title setText:@"News Feed"];
    
    _expandMenuBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 44, 44)];
    [_expandMenuBtn setBackgroundColor:[UIColor whiteColor]];
    [_expandMenuBtn addTarget:self action:@selector(switchMenuState) forControlEvents:UIControlEventTouchDown];
    
    [self addSubview:_title];
    [self addSubview:_expandMenuBtn];
}

- (void) switchMenuState {
    if (_menuExpanded) {
        [UIView animateWithDuration:0.5 animations:^{
            [[self superview].subviews[0] setFrame:CGRectMake(0, 0, 240, [self superview].frame.size.height)];
            [[self superview] setFrame:CGRectMake(0, 0, [self superview].frame.size.width, [self superview].frame.size.height)];
        }];
    } else {
        [UIView animateWithDuration:0.5 animations:^{
            [[self superview].subviews[0] setFrame:CGRectMake(-240, 0, 240, [self superview].frame.size.height)];
            [[self superview] setFrame:CGRectMake(240, 0, [self superview].frame.size.width, [self superview].frame.size.height)];
        }];
    }
    
    _menuExpanded = !_menuExpanded;
}

@end
