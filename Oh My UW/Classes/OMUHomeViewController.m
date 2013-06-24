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

@interface OMUHomeViewController ()

@end

@implementation OMUHomeViewController

- (id)init {
    self = [super initWithTitle:@"Home"];
    if (self) {
        // Custom initialization
        [self setupTableView];
        _weatherLoading = YES;
        _successfulFetch = NO;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

	// Do any additional setup after loading the view.
    [self fetchWeather];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setupTableView {
    _tableView = [[UITableView alloc] initWithFrame:[OMUDefaultViewController viewFrame]];
    [_tableView setBackgroundColor:[UIColor colorWithWhite:0.9 alpha:1]];
    [_tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [_tableView setDelegate:self];
    [_tableView setDataSource:self];
    [_contentView addSubview:_tableView];
    
    UIRefreshControl *refreshControl = [[UIRefreshControl alloc] init];
    [refreshControl addTarget:self action:@selector(refresh:) forControlEvents:UIControlEventValueChanged];
    [_tableView addSubview:refreshControl];
}

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
                cell = [[OMUWeatherCell alloc] initWithWeather:[OMUWeatherModel sharedInstance]];
            }
        } else if (_weatherLoading) {
            cell = [_tableView dequeueReusableCellWithIdentifier:@"loadingCell"];
            
            if (!cell) {
                cell = [[OMUDefaultLoadingCell alloc] initWithHeight:WEATHER_CELL_HEIGHT andText:@"Loading Weather..."];
            }
        } else {
            cell = [_tableView dequeueReusableCellWithIdentifier:@"errorCell"];
            
            if (!cell) {
                cell = [[OMUErrorCell alloc] initWithHeight:WEATHER_CELL_HEIGHT andText:@"Something Went Wrong. Pull to Try Again."];
            }
        }
    } else {
        cell = [_tableView dequeueReusableCellWithIdentifier:[OMUMainImageCell reuseIdentifier]];
        
        if (!cell) {
            cell = [[OMUMainImageCell alloc] initWithCellType:(MainCellType)(indexPath.row - 1)];
        }
    }
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [_tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.row == 1) {
        OMUSchoolOrganizerViewController * vc = [[OMUSchoolOrganizerViewController alloc] init];
        [vc setBackButtonVisible:YES];
        [self.navigationController pushViewController:vc animated:YES];
    }
}

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
        [_tableView reloadData];
    }];
    
    // Disable caching
    [operation setCacheResponseBlock:^NSCachedURLResponse *(NSURLConnection *connection, NSCachedURLResponse *cachedResponse) {
        return nil;
    }];
    
    [operation start];
}

@end
