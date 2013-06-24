//
//  OMUSchoolOrganizerViewController.m
//  Oh_My_UW
//
//  Created by Eric Lui on 2013-06-23.
//  Copyright (c) 2013 Eric Lui. All rights reserved.
//

#import "OMUSchoolOrganizerViewController.h"

@interface OMUSchoolOrganizerViewController ()

@end

@implementation OMUSchoolOrganizerViewController

- (id)init {
    self = [super initWithTitle:@"Home"];
    if (self) {
        // Custom initialization
        [self setupTableView];
    }
    return self;
}

- (void)setupTableView {
    _tableView = [[UITableView alloc] initWithFrame:[OMUDefaultViewController viewFrame]];
    [_tableView setBackgroundColor:[UIColor colorWithWhite:0.9 alpha:1]];
    [_tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [_tableView setDelegate:self];
    [_tableView setDataSource:self];
    [_contentView addSubview:_tableView];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 6;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        return WEATHER_CELL_HEIGHT;
    }
    else {
        return MAIN_CELL_HEIGHT;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"menuCell"];
    
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithFrame:CGRectMake(0, 0, SIDE_MENU_WIDTH, 50.0f)];
    }
    
    [cell.textLabel setText:[NSString stringWithFormat:@"Menu Item %d", indexPath.row]];
    
    return cell;
}



@end
