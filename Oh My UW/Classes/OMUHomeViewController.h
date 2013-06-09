//
//  OMUHomeViewController.h
//  Oh_My_UW
//
//  Created by Eric Lui on 2013-06-08.
//  Copyright (c) 2013 Eric Lui. All rights reserved.
//

#import "OMUDefaultViewController.h"

@interface OMUHomeViewController : OMUDefaultViewController <UITableViewDataSource, UITableViewDelegate> {
    UITableView * _tableView;
    BOOL _weatherLoading;
    BOOL _successfulFetch;
}

- (id)init;

@end
