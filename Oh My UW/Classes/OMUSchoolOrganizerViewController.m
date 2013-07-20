//
//  OMUSchoolOrganizerViewController.m
//  Oh_My_UW
//
//  Created by Eric Lui on 2013-06-23.
//  Copyright (c) 2013 Eric Lui. All rights reserved.
//

#import "OMUSchoolOrganizerViewController.h"
#import "OMUSideMenu.h"
#import "OMUCoursesViewController.h"
#import "OMUUIUtils.h"

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
    _tableView = [UITableView defaultTableViewWithDelegateAndDataSource:self];
    [_contentView addSubview:_tableView];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [[[OMUSideMenu sectionRowTitles] objectAtIndex:sectionTypeSchool] count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return DEFAULT_CELL_HEIGHT;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"menuCell"];
    
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithFrame:CGRectMake(0, 0, 320.0f, 50.0f)];
    }
    
    [cell.textLabel setText:[[[OMUSideMenu sectionRowTitles] objectAtIndex:sectionTypeSchool] objectAtIndex:indexPath.row]];
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.row == 0) {
        OMUCoursesViewController * vc = [[OMUCoursesViewController alloc] init];
        [vc setBackButtonVisible:YES];
        [self pushViewController:vc];
    }
}

@end
