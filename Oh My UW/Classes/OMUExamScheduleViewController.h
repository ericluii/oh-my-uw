//
//  OMUExamScheduleViewController.h
//  Oh_My_UW
//
//  Created by Eric Lui on 2013-07-26.
//  Copyright (c) 2013 Eric Lui. All rights reserved.
//

#import "OMUDefaultViewController.h"

@interface OMUExamScheduleViewController : OMUDefaultViewController <UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate> {
    UITableView * _tableView;
}

@end
