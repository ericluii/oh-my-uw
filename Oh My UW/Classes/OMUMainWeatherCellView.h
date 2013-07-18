//
//  OMUMainWeatherCellView.h
//  Oh_My_UW
//
//  Created by Eric Lui on 2013-06-08.
//  Copyright (c) 2013 Eric Lui. All rights reserved.
//

#import <UIKit/UIKit.h>

@class OMUWeatherModel;
@interface OMUMainWeatherCellView : UIView {
    NSString * _summaryText;
    NSString * _currentTemperatureText;
    
    CGRect _conditionFrame;
    CGRect _currentTempFrame;
    CGRect _summaryFrame;
    CGRect _dividerFrame;
    
    UIFont * _smallFont;
    UIFont * _largeFont;
}

@property (nonatomic, strong) OMUWeatherModel * weather;
@property (nonatomic, strong) UIImageView * mainWeatherImage;

- (void) configureWithWeather:(OMUWeatherModel *) weather;

@end
