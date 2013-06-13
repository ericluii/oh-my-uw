//
//  OMUDefaultLoadingCell.h
//  Oh_My_UW
//
//  Created by Eric Lui on 2013-06-12.
//  Copyright (c) 2013 Eric Lui. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OMUDefaultCellWrapper.h"

@interface OMUDefaultLoadingCell : UITableViewCell

@property (nonatomic, strong) OMUDefaultCellWrapper * wrapper;

- (id)initWithHeight:(CGFloat) height andText:(NSString *) text;
+ (NSString *) reuseIdentifier;

@end
