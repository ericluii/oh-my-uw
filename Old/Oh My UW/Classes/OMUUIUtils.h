//
//  OMUUIUtils.h
//  Oh_My_UW
//
//  Created by Eric Lui on 2013-07-19.
//  Copyright (c) 2013 Eric Lui. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OMUUIUtils : NSObject

+(CGRect) fullscreenFrame;

@end

@interface UITableView (OMUDefaultTableView)

+ (UITableView *) defaultTableViewWithDelegateAndDataSource:(id) delegateDataSource;

@end