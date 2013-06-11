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
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        return WEATHER_CELL_HEIGHT;
    }
    else {
        return 150.0f;
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
                cell = [[UITableViewCell alloc] initWithFrame:CGRectMake(0, 0, 320.0f, 50.0f)];
            }
            
            cell.textLabel.text = @"Loading";
        } else {
            cell = [_tableView dequeueReusableCellWithIdentifier:@"errorCell"];
            
            if (!cell) {
                cell = [[UITableViewCell alloc] initWithFrame:CGRectMake(0, 0, 320.0f, 50.0f)];
            }
            
            cell.textLabel.text = @"Something Went Wrong";
        }
    }
    
    return cell;
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
    [operation start];
}

@end
