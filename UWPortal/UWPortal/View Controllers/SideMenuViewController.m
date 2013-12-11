//
//  SideMenuViewController.m
//  UWPortal
//
//  Created by Eric Lui on 12/10/2013.
//  Copyright (c) 2013 Eric Lui. All rights reserved.
//

#import "SideMenuViewController.h"

@interface SideMenuViewController () {
    NSInteger _openSectionIndex;
}
@end

@implementation SideMenuViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        _openSectionIndex = NSNotFound;
        [self.view setBackgroundColor:[UIColor blueColor]];
        [self setTitle:@"Home"];
        
        UILabel * lbl = [[UILabel alloc] initWithFrame:CGRectMake(0, 200, 200, 200)];
        [lbl setText:@"IOGARWJJGAREIGAREIOJ"];
        [self.view addSubview:lbl];
        
        UIPanGestureRecognizer * panDetection = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panHandler:)];
        [self.view addGestureRecognizer:panDetection];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    _sideMenuView = [[SideMenuView alloc] initWithMenuDelegate:self];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [[[UIApplication sharedApplication] keyWindow] addSubview:_sideMenuView];
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    [_sideMenuView removeFromSuperview];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return numberOfCellType;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [[[SideMenuView sectionRowTitles] objectAtIndex:section] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"bob"];
    
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"bob"];
        [cell setBackgroundColor:[UIColor clearColor]];
    }

    [cell.textLabel setText:[[[SideMenuView sectionRowTitles]
                                objectAtIndex:indexPath.section]
                                objectAtIndex:indexPath.row]];
    
    return cell;
}

- (void) panHandler:(UIPanGestureRecognizer *) recognizer {
    [_sideMenuView panHandler:recognizer];
}

@end
