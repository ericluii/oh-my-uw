//
//  OMUSchoolOrganizerViewController.h
//  Oh_My_UW
//
//  Created by Eric Lui on 2013-06-23.
//  Copyright (c) 2013 Eric Lui. All rights reserved.
//

#import "OMUDefaultViewController.h"

@interface OMUSchoolOrganizerViewController : OMUDefaultViewController <UITableViewDataSource, UITableViewDelegate> {
    UITableView * _tableView;
}

@end
