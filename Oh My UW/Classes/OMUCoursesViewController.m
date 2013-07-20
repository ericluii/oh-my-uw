//
//  OMUCoursesViewController.m
//  Oh_My_UW
//
//  Created by Eric Lui on 2013-07-19.
//  Copyright (c) 2013 Eric Lui. All rights reserved.
//

#import "OMUCoursesViewController.h"
#import "OMUUIUtils.h"

@interface OMUCoursesViewController ()

@end

@implementation OMUCoursesViewController

- (id)init {
    self = [super initWithTitle:@"Courses"];
    if (self) {
        // Custom initialization
        [self setupTableView];
    }
    return self;
}

- (void) setupTableView {
    _tableView = [UITableView defaultTableViewWithDelegateAndDataSource:self];
    [_contentView addSubview:_tableView];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    return nil;
}

@end
