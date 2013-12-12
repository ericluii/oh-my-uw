//
//  HomeViewController.h
//  UWPortal
//
//  Created by Eric Lui on 12/11/2013.
//  Copyright (c) 2013 Eric Lui. All rights reserved.
//

#import "SideMenuViewController.h"

@interface HomeViewController : SideMenuViewController <UITableViewDataSource, UITableViewDelegate> {
    
}

@property(nonatomic, strong) UITableView* widgetTable;

- (id)init;

@end
