//
//  OMUCoursesViewController.h
//  Oh_My_UW
//
//  Created by Eric Lui on 2013-07-19.
//  Copyright (c) 2013 Eric Lui. All rights reserved.
//

#import "OMUDefaultViewController.h"

@interface OMUCoursesViewController : OMUDefaultViewController <UITableViewDataSource, UITableViewDelegate> {
    UITableView * _tableView;
}

@end
