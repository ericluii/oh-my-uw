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
    CGRect _textWrapper;
    CGRect _shadowX;
    CGRect _shadowY;
    
    UIColor * _shadowColor;
    UIColor * _wrapperColor;
}

- (id)initWithHeight:(CGFloat) height andText:(NSString *) text;
- (id)initWithHeight:(CGFloat) height andText:(NSString *) text andIdentifer:(NSString *) identifier;
+ (NSString *) reuseIdentifier;

@end
