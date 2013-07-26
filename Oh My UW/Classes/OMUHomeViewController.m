//
//  OMUHomeViewController.m
//  Oh_My_UW
//
//  Created by Eric Lui on 2013-06-08.
//  Copyright (c) 2013 Eric Lui. All rights reserved.
//

#import "OMUHomeViewController.h"
#import "OMUNavigationConstants.h"
#import "OMURequestConstants.h"
#import "AFJSONRequestOperation.h"
#import "OMUWeatherModel.h"
#import "OMUWeatherCell.h"
#import "OMUDefaultLoadingCell.h"
#import "OMUMainImageCell.h"
#import "OMUErrorCell.h"
#import "OMUSchoolOrganizerViewController.h"
#import "OMUUIUtils.h"
#import "OMUSideMenu.h"

@interface OMUHomeViewController ()

@end

@implementation OMUHomeViewController

- (id)init {
    self = [super initWithTitle:@"Home"];
    if (self) {
        // Custom initialization
        _weatherLoading = YES;
        _successfulFetch = NO;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

	// Do any additional setup after loading the view.
    [self setupTableView];
    [self fetchWeather];
}

#pragma mark - Setup Methods

- (void)setupTableView {
    _tableView = [UITableView defaultTableViewWithDelegateAndDataSource:self];
    [_tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [self addSubview:_tableView];
    
    UIRefreshControl *refreshControl = [[UIRefreshControl alloc] init];
    [refreshControl addTarget:self action:@selector(refresh:) forControlEvents:UIControlEventValueChanged];
    [_tableView addSubview:refreshControl];
}

#pragma mark - UITableview Delegate and Datasource Methods

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1 + numberOfCellType;
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
    UITableViewCell * cell;
    
    if (indexPath.row == 0) {
        if (!_weatherLoading && _successfulFetch) {
            cell = [_tableView dequeueReusableCellWithIdentifier:[OMUWeatherCell reuseIdentifier]];
            
            if (!cell) {
                cell = [[OMUWeatherCell alloc] init];
            }
            
            [((OMUWeatherCell *)cell) configureWithWeather:[OMUWeatherModel sharedInstance]];
        } else if (_weatherLoading) {
            cell = [_tableView dequeueReusableCellWithIdentifier:[OMUDefaultLoadingCell reuseIdentifier]];
            
            if (!cell) {
                cell = [[OMUDefaultLoadingCell alloc] initWithHeight:WEATHER_CELL_HEIGHT andText:@"Loading Weather..."];
            }
            
            [(OMUDefaultLoadingCell *)cell startAnimation];
        } else {
            cell = [_tableView dequeueReusableCellWithIdentifier:[OMUErrorCell reuseIdentifier]];
            
            if (!cell) {
                cell = [[OMUErrorCell alloc] initWithHeight:WEATHER_CELL_HEIGHT andText:@"Something Went Wrong. Pull to Try Again."];
            }
        }
    } else {
        cell = [_tableView dequeueReusableCellWithIdentifier:[OMUMainImageCell reuseIdentifier]];
        
        if (!cell) {
            cell = [[OMUMainImageCell alloc] init];
        }
        
        [(OMUMainImageCell *)cell configureForCellType:(MainCellType)(indexPath.row - 1)];
    }
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    [self pushViewController:[OMUSideMenu viewControllerForSection:sectionTypeHome andRow:indexPath.row]];
}

#pragma mark - Request Methods

- (void)refresh:(UIRefreshControl *)refreshControl {
    _weatherLoading = YES;
    _successfulFetch = NO;
    [_tableView reloadData];
    [self fetchWeather];
    [refreshControl endRefreshing];
}

- (void) fetchWeather {
    NSURLRequest *request = [NSURLRequest requestWithURL:[OMURequestConstants weatherURL]];
    AFJSONRequestOperation *operation = [AFJSONRequestOperation JSONRequestOperationWithRequest:request success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {
        NSLog(@"Weather Successfully Fetched");
        [[OMUWeatherModel sharedInstance] configureWithJSONResponse:[[JSON objectForKey:@"response"] objectForKey:@"data"]];
        _weatherLoading = NO;
        [_tableView reloadData];
        _successfulFetch = YES;
    } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id JSON) {
        NSLog(@"Weather Failed to Fetch: %@", error);
        _weatherLoading = NO;
        _successfulFetch = NO;
        [_tableView reloadData];
    }];
    
    // Disable caching
    [operation setCacheResponseBlock:^NSCachedURLResponse *(NSURLConnection *connection, NSCachedURLResponse *cachedResponse) {
        return nil;
    }];
    
    [operation start];
}

@end
