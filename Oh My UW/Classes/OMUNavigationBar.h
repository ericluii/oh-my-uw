//
//  OMUNavigationBar.h
//  Oh_My_UW
//
//  Created by Eric Lui on 2013-05-28.
//  Copyright (c) 2013 Eric Lui. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OMUNavigationConstants.h"

@interface OMUNavigationBar : UIView {
    UIImageView * _background;
    UILabel * _title;
    UIButton * _expandMenuBtn;
    UIButton * _backBtn;
}

@property (nonatomic, strong) UINavigationController * navigator;
@property (nonatomic) BOOL menuExpanded;


- (id)initWithTitle:(NSString*) title;
- (void) backButtonIsVisisble:(BOOL) visible;

@end
