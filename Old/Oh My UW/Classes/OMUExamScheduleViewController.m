//
//  OMUExamScheduleViewController.m
//  Oh_My_UW
//
//  Created by Eric Lui on 2013-07-26.
//  Copyright (c) 2013 Eric Lui. All rights reserved.
//

#import "OMUExamScheduleViewController.h"
#import "OMUUIUtils.h"
#import "OMUExamScheduleCourse.h"
#import "OMUErrorCell.h"
#import "OMUDeviceUtils.h"
#import "OMUImageManager.h"

@interface OMUExamScheduleViewController () {
    NSMutableArray * _examScheduleArray, * _filteredExamSchedulArray;
    OMULoadingView * _loadScreen;
    bool _showingSearchView;
    NSString * _term;
    UISearchBar * _searchView;
}

@end

@implementation OMUExamScheduleViewController

- (id)init {
    self = [super initWithTitle:@"Exam Schedule"];
    if (self) {
        // Custom initialization
        _showingSearchView = NO;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
	// Do any additional setup after loading the view.
    [self setupTableView];
    [self setupSearchView];
    [self setupBarButton];
    
    _loadScreen = [[OMULoadingView alloc] init];
    [self addSubview:_loadScreen];
    [_loadScreen setDelegate:self];
    [_loadScreen showLoadscreenWithMessage:@"Loading Exam Schedule..." andError:NO];
    
    [[OMUCoursesManager sharedInstance] setDelegate:self];
    [[OMUCoursesManager sharedInstance] getExamSchedule];
}

#pragma mark - Setup Methods

- (void) setupTableView {
    _tableView = [UITableView defaultTableViewWithDelegateAndDataSource:self];
    [self addSubview:_tableView];
}

- (void) setupSearchView {
    _searchView = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.frame), NAV_BAR_HEIGHT)];
    [_searchView setPlaceholder:@"Example: CS 136, MATH 239, etc."];
    [_searchView setDelegate:self];
    
    // Hack to always have search button enabled
    for (UIView *subview in _searchView.subviews) {
        if ([subview isKindOfClass:[UITextField class]]) {
            ((UITextField *)subview).enablesReturnKeyAutomatically = NO;
            break;
        }
    }
    
    [self insertSubview:_searchView atIndex:0];
}

- (void) setupBarButton {
    UIButton * searchButton = [[UIButton alloc] initWithFrame:CGRectMake(320.0f - NAV_BAR_HEIGHT - 6, 2 + ([OMUDeviceUtils isIOS7] ? STATUS_BAR_HEIGHT : 0), NAV_BAR_HEIGHT - 4, NAV_BAR_HEIGHT - 4)];
    [searchButton setBackgroundImage:[[OMUImageManager sharedInstance] getImageNamed:@"main_image_news"] forState:UIControlStateNormal];
    [searchButton addTarget:self action:@selector(searchButtonPressed) forControlEvents:UIControlEventTouchUpInside];
    [self setRightBarButton:searchButton];
}

#pragma mark - Bar Button Methods

- (void) searchButtonPressed {
    [UIView animateWithDuration:0.2f animations:^{
        CGRect searchFrame = _searchView.frame;
        CGRect tableViewFrame = _tableView.frame;
        
        if (_showingSearchView) {
            searchFrame.origin.y = 0;
            tableViewFrame.origin.y -= NAV_BAR_HEIGHT;
            tableViewFrame.size.height += NAV_BAR_HEIGHT;
            [_searchView setText:@""];
            _filteredExamSchedulArray = [NSMutableArray arrayWithArray:_examScheduleArray];
            [_searchView endEditing:YES];
        } else {
            searchFrame.origin.y = NAV_BAR_HEIGHT;
            tableViewFrame.origin.y += NAV_BAR_HEIGHT;
            tableViewFrame.size.height -= NAV_BAR_HEIGHT;
            [_searchView becomeFirstResponder];
        }
        
        [_searchView setFrame:searchFrame];
        [_tableView setFrame:tableViewFrame];
    }];
    
    _showingSearchView = !_showingSearchView;
    [_tableView reloadData];
}

#pragma mark - UISearchBar Delegate Methods

- (void) updateFilteredCourses {
    _filteredExamSchedulArray = [[NSMutableArray alloc] init];
    BOOL searchIsValid = (_showingSearchView && _searchView.text.length > 0);
    
    for (OMUExamScheduleCourse * examCourse in _examScheduleArray) {
        if (searchIsValid && [examCourse.course rangeOfString:_searchView.text options:NSCaseInsensitiveSearch].location == NSNotFound) {
            continue;
        } else {
            [_filteredExamSchedulArray addObject:examCourse];
        }
    }
    
    [_tableView reloadData];
}

- (void) searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
    [self updateFilteredCourses];
}

- (void) searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    [_searchView endEditing:YES];
    [self updateFilteredCourses];
}

#pragma mark - UITableview Delegate and Datasource Methods

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return WEATHER_CELL_HEIGHT;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (_showingSearchView) {
        return _filteredExamSchedulArray ? [_filteredExamSchedulArray count] + 1 : 1;
    } else {
        return _examScheduleArray ? [_examScheduleArray count] + 1 : 1;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell * cell;
    NSArray * array = _showingSearchView ? _filteredExamSchedulArray : _examScheduleArray;
    
    if (indexPath.row == 0) {
        cell = [_tableView dequeueReusableCellWithIdentifier:[OMUErrorCell reuseIdentifier]];
        
        if (!cell) {
            cell = [[OMUErrorCell alloc] initWithHeight:WEATHER_CELL_HEIGHT andText:[NSString stringWithFormat:@"Note: This exam schedule is for the latest available term: %@. If you are looking for a different term, please check online.", _term]];
        } else {
            if ([array count] > 0) {
                [(OMUErrorCell *)cell setErrorText:[NSString stringWithFormat:@"Note: This exam schedule is for the latest available term: %@. If you are looking for a different term, please check online.", _term]];
            } else {
                [(OMUErrorCell *)cell setErrorText:@"No Results."];
            }
        }
    } else {
        cell = [tableView dequeueReusableCellWithIdentifier:@"examCell"];
        
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"examCell"];
        }

        OMUExamScheduleCourse * course = (OMUExamScheduleCourse *)[array objectAtIndex:indexPath.row - 1];
        NSString *examInfo = [NSString stringWithFormat:@"%@, %@, %@, %@, %@, %@, %@, %@",
                              course.course,
                              course.term,
                              course.section,
                              course.day,
                              course.date,
                              course.startTime,
                              course.endTime,
                              course.Location];
        cell.textLabel.numberOfLines = 0;
        cell.textLabel.font = [UIFont systemFontOfSize:13.0f];
        cell.textLabel.text = examInfo;
    }
    
    return cell;
}

#pragma mark - OMULoadingViewDelegate Methods

- (void) loadingViewRetryButtonPressed {
    [_loadScreen showLoadscreenWithMessage:@"Loading Exam Schedule..." andError:NO];
    [[OMUCoursesManager sharedInstance] getExamSchedule];
}

#pragma mark - OMUCourseManagerDelegate Methods

- (void) OMUCoursesManagerCompletedRequestWithSuccess:(id)result {
    _term = [result objectForKey:@"term"];
    _examScheduleArray = [result objectForKey:@"courses"];
    _filteredExamSchedulArray = [NSMutableArray arrayWithArray:_examScheduleArray];
    [_loadScreen hideLoadingMessage];
    [_tableView reloadData];
}

- (void)OMUCoursesManagerCompletedRequestWithError:(NSError *)error {
    _examScheduleArray = nil;
    _filteredExamSchedulArray = nil;
    [_loadScreen showLoadscreenWithMessage:@"Something Went Wrong. Please Try Again Later." andError:YES];
}

@end