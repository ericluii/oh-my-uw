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
#import "OMUExamScheduleViewController.h"

@interface OMUSchoolOrganizerViewController ()

@end

@implementation OMUSchoolOrganizerViewController

- (id)init {
    self = [super initWithTitle:@"School Organizer"];
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
    [self pushViewController:[OMUSideMenu viewControllerForSection:sectionTypeSchool andRow:indexPath.row]];
}

@end
