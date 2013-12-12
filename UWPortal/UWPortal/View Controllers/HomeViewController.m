//
//  HomeViewController.m
//  UWPortal
//
//  Created by Eric Lui on 12/11/2013.
//  Copyright (c) 2013 Eric Lui. All rights reserved.
//

#import "HomeViewController.h"
#import "ExamScheduleViewController.h"

@interface HomeViewController ()

@end

@implementation HomeViewController

- (id)init {
    self = [super initWithTitle:@"Home"];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    _widgetTable = [[UITableView alloc] initWithFrame:self.view.frame];
    [_widgetTable setDelegate:self];
    [_widgetTable setDataSource:self];
    [self.view addSubview:_widgetTable];
}

-(void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"bingo"];
    
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"bingo"];
    }
    
    [cell.textLabel setText:@"Weather Info"];
    
    return cell;
}

@end
