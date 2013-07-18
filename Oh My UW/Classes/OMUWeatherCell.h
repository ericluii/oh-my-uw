//
//  OMUWeatherCell.h
//  Oh_My_UW
//
//  Created by Eric Lui on 2013-06-08.
//  Copyright (c) 2013 Eric Lui. All rights reserved.
//

#import <UIKit/UIKit.h>

@class OMUMainWeatherCellView;
@class OMUWeatherModel;
@interface OMUWeatherCell : UITableViewCell <UIScrollViewDelegate> {
    CGRect _shadowX;
    CGRect _shadowY;
    CGRect _wrapper;
    UIColor * _shadowColor;
    UIColor * _wrapperColor;
}

@property (nonatomic, strong) UIScrollView * scroller;
@property (nonatomic, strong) OMUMainWeatherCellView * mainWeatherView;

+ (NSString *) reuseIdentifier;
- (void) configureWithWeather:(OMUWeatherModel *)weather;

@end
