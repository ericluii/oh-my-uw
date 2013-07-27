//
//  OMUDirectionViewController.m
//  Oh_My_UW
//
//  Created by Eric Lui on 2013-07-27.
//  Copyright (c) 2013 Eric Lui. All rights reserved.
//

#import "OMUDirectionViewController.h"
#import "OMUUIUtils.h"

@implementation OMUDirectionViewController

- (id)init {
    self = [super initWithTitle:@"Directions"];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupTableView];
}

#pragma mark - Setup Methods

- (void)setupTableView {
    _tableView = [UITableView defaultTableViewWithDelegateAndDataSource:self];
    [self addSubview:_tableView];
}

#pragma mark - UITableview Delegate and Datasource methods

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [[[OMUSideMenu sectionRowTitles] objectAtIndex:sectionTypeDirection] count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return DEFAULT_CELL_HEIGHT;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"menuCell"];
    
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithFrame:CGRectMake(0, 0, 320.0f, 50.0f)];
    }
    
    [cell.textLabel setText:[[[OMUSideMenu sectionRowTitles] objectAtIndex:sectionTypeDirection] objectAtIndex:indexPath.row]];
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    [self pushViewController:[OMUSideMenu viewControllerForSection:sectionTypeDirection andRow:indexPath.row]];
}

@end
