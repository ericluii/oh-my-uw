//
//  OMUUIUtils.m
//  Oh_My_UW
//
//  Created by Eric Lui on 2013-07-19.
//  Copyright (c) 2013 Eric Lui. All rights reserved.
//

#import "OMUUIUtils.h"
#import "OMUDefaultViewController.h"

@implementation UITableView (OMUDefaultTableView)

+ (UITableView *) defaultTableViewWithDelegateAndDataSource:(id) delegateDataSource {
    UITableView * table = [[UITableView alloc] initWithFrame:[OMUDefaultViewController viewFrame]];
    [table setBackgroundColor:[UIColor colorWithWhite:0.9 alpha:1]];
    [table setDelegate:delegateDataSource];
    [table setDataSource:delegateDataSource];
    return table;
}

@end