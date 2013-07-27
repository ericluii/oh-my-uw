//
//  OMUUIUtils.m
//  Oh_My_UW
//
//  Created by Eric Lui on 2013-07-19.
//  Copyright (c) 2013 Eric Lui. All rights reserved.
//

#import "OMUUIUtils.h"
#import "OMUDefaultViewController.h"
#import "OMUNavigationConstants.h"
#import "OMUDeviceUtils.h"

@implementation OMUUIUtils

+(CGRect) fullscreenFrame {
    return CGRectMake(0, [OMUDeviceUtils isIOS7] ? STATUS_BAR_HEIGHT + NAV_BAR_HEIGHT : NAV_BAR_HEIGHT, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height - NAV_BAR_HEIGHT - STATUS_BAR_HEIGHT);
}

@end

@implementation UITableView (OMUDefaultTableView)

+ (UITableView *) defaultTableViewWithDelegateAndDataSource:(id) delegateDataSource {
    UITableView * table = [[UITableView alloc] initWithFrame:[OMUUIUtils fullscreenFrame]];
    [table setBackgroundColor:[UIColor colorWithWhite:0.9 alpha:1]];
    [table setDelegate:delegateDataSource];
    [table setDataSource:delegateDataSource];
    return table;
}

@end