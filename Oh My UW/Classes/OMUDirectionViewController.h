//
//  OMUDirectionViewController.h
//  Oh_My_UW
//
//  Created by Eric Lui on 2013-07-27.
//  Copyright (c) 2013 Eric Lui. All rights reserved.
//

#import "OMUDefaultViewController.h"

@interface OMUDirectionViewController : OMUDefaultViewController <UITableViewDataSource, UITableViewDelegate> {
    UITableView * _tableView;
}

@end
