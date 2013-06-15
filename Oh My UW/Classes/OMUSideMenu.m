//
//  OMUSideMenu.m
//  Oh_My_UW
//
//  Created by Eric Lui on 2013-05-30.
//  Copyright (c) 2013 Eric Lui. All rights reserved.
//

#import "OMUSideMenu.h"
#import "OMUNavigationConstants.h"
#import "OMUDeviceUtils.h"

@implementation OMUSideMenu

- (id)init {
    self = [super initWithFrame:CGRectMake(0, [OMUDeviceUtils isIOS7] ? STATUS_BAR_HEIGHT : 0, SIDE_MENU_WIDTH, [UIScreen mainScreen].bounds.size.height - ([OMUDeviceUtils isIOS7] ? STATUS_BAR_HEIGHT * 2 : 0))];
    if (self) {
        // Initialization code
        [self setupMenu];
    }
    return self;
}

- (void) setupMenu {
    _menu = [[UITableView alloc] initWithFrame:self.frame];
    [_menu setDelegate:self];
    [_menu setDataSource:self];
    [_menu setBackgroundColor:[UIColor colorWithRed:64/255.0 green:64/255.0 blue:64/255.0 alpha:1]];
    [self addSubview:_menu];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 4;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"menuCell"];
    
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithFrame:CGRectMake(0, 0, SIDE_MENU_WIDTH, 50.0f)];
    }
    
    [cell.textLabel setText:[NSString stringWithFormat:@"Menu Item %d", indexPath.row]];
    
    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return @"Header";
}

@end
