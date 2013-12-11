//
//  HomeViewController.m
//  UWPortal
//
//  Created by Eric Lui on 12/11/2013.
//  Copyright (c) 2013 Eric Lui. All rights reserved.
//

#import "HomeViewController.h"

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
//    [_widgetTable setDelegate:self];
//    [_widgetTable setDataSource:self];
    [self.view addSubview:_widgetTable];
}

@end
