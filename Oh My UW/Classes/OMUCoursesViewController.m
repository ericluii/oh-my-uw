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
    }
    return self;
}

-(void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupTableView];
}

#pragma mark - Setup Methods

- (void) setupTableView {
    _tableView = [UITableView defaultTableViewWithDelegateAndDataSource:self];
    [self addSubview:_tableView];
}

#pragma mark - UITableview Delegate and Datasource Methods

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    return nil;
}

@end
