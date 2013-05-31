//
//  OMUViewController.m
//  Oh My UW
//
//  Created by Eric Lui on 2013-05-17.
//  Copyright (c) 2013 Eric Lui. All rights reserved.
//

#import "OMUViewController.h"
#import "OMUAppDelegate.h"

@interface OMUViewController ()

@end

@implementation OMUViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.view addSubview:((OMUAppDelegate *)[[UIApplication sharedApplication] delegate]).navBar];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
