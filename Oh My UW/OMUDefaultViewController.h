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

@interface OMUDefaultViewController : UIViewController {
    OMUNavigationBar *_navBar;
    OMUSideMenu *_sideMenu;
}

- (id)initWithTitle:(NSString *) title;
+(CGRect)viewFrame;

@end
