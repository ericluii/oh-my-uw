//
//  OMUInfoCell.h
//  Oh_My_UW
//
//  Created by Eric Lui on 2013-06-23.
//  Copyright (c) 2013 Eric Lui. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OMUInfoCell : UITableViewCell {
    NSString * _loadingText;
    CGRect _wrapper;
}

- (id)initWithHeight:(CGFloat) height andText:(NSString *) text;
+ (NSString *) reuseIdentifier;

@end