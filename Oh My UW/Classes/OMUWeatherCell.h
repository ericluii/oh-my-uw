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
    CGRect _shadow;
    CGRect _wrapper;
}

@property (nonatomic, strong) UIScrollView * scroller;
@property (nonatomic, strong) OMUMainWeatherCellView * mainWeatherView;
@property (nonatomic, strong) OMUWeatherModel * weather;

- (id)initWithWeather:(OMUWeatherModel *) weather;
+ (NSString *) reuseIdentifier;

@end
