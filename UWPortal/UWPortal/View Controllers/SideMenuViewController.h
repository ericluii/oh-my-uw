//
//  SideMenuViewController.h
//  UWPortal
//
//  Created by Eric Lui on 12/10/2013.
//  Copyright (c) 2013 Eric Lui. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SideMenuView.h"
#import "SideMenuHeaderView.h"


// Removed SideMenuHeaderViewDelegate to temporarily disable tap to expand

@interface SideMenuViewController : UIViewController <UITableViewDelegate, UITableViewDataSource> {
    SideMenuView *_sideMenuView;
    SectionType _openSection;
}

@end
