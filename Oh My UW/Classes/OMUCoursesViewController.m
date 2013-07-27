//
//  OMUCoursesViewController.m
//  Oh_My_UW
//
//  Created by Eric Lui on 2013-07-19.
//  Copyright (c) 2013 Eric Lui. All rights reserved.
//

#import "OMUCoursesViewController.h"
#import "OMUUIUtils.h"
#import "OMUDepartment.h"

@interface OMUCoursesViewController () {
    NSMutableArray * _departmentsArray;
    OMULoadingView * _loadingScreen;
}

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
    
    _loadingScreen = [[OMULoadingView alloc] init];
    [self addSubview:_loadingScreen];
    [_loadingScreen showLoadscreenWithMessage:@"Loading Courses..." andError:NO];
    
    [[OMUCoursesManager sharedInstance] setDelegate:self];
    [[OMUCoursesManager sharedInstance] getDepartments];
}

#pragma mark - Setup Methods

- (void) setupTableView {
    _tableView = [UITableView defaultTableViewWithDelegateAndDataSource:self];
    [self addSubview:_tableView];
}

#pragma mark - UITableview Delegate and Datasource Methods

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _departmentsArray ? [_departmentsArray count] : 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell * cell;
    
    cell = [tableView dequeueReusableCellWithIdentifier:@"departmentCell"];
    
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"departmentCell"];
    }
    
    OMUDepartment * department = (OMUDepartment *)[_departmentsArray objectAtIndex:indexPath.row];
    [cell.textLabel setText:[NSString stringWithFormat:@"%@ - %@", department.acronym, department.name]];
    
    return cell;
}

- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView {
    NSMutableSet * uniqueCharacters = [NSMutableSet set];
    
    for (OMUDepartment *department in _departmentsArray) {
        [uniqueCharacters addObject:[department.acronym substringToIndex:1]];
    }
    
    return [[NSArray arrayWithArray:[uniqueCharacters allObjects]] sortedArrayUsingComparator:
            ^NSComparisonResult(NSString * obj1, NSString * obj2) {
                return [obj1 compare:obj2] == NSOrderedDescending;
            }];
}

- (NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index {
    
    NSInteger newRow = [self indexForFirstChar:title inArray:_departmentsArray];
    NSIndexPath *newIndexPath = [NSIndexPath indexPathForRow:newRow inSection:0];
    [tableView scrollToRowAtIndexPath:newIndexPath atScrollPosition:UITableViewScrollPositionTop animated:NO];
    
    return index;
}

// Return the index for the location of the first item in an array that begins with a certain character
- (NSInteger)indexForFirstChar:(NSString *)character inArray:(NSArray *)array
{
    NSUInteger count = 0;
    for (OMUDepartment *department in array) {
        if ([department.acronym hasPrefix:character]) {
            return count;
        }
        count++;
    }
    
    return 0;
}

#pragma mark - OMULoadingViewDelegate Methods

-(void)loadingViewRetryButtonPressed {
    [_loadingScreen showLoadscreenWithMessage:@"Loading Courses..." andError:NO];
    [[OMUCoursesManager sharedInstance] getDepartments];
}

#pragma mark - OMUCoursesManagerDelegate Methods

- (void) OMUCoursesManagerCompletedRequestWithSuccess:(id)result {
    [_loadingScreen hideLoadingMessage];
    _departmentsArray = result;
    [_tableView reloadData];
}

-(void) OMUCoursesManagerCompletedRequestWithError:(NSError *)error {
    [_loadingScreen showLoadscreenWithMessage:@"Something Went Wrong. Please Try Again Later." andError:YES];
}

@end
