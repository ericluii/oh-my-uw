//
//  OMUMainWeatherCellView.h
//  Oh_My_UW
//
//  Created by Eric Lui on 2013-06-08.
//  Copyright (c) 2013 Eric Lui. All rights reserved.
//

#import <UIKit/UIKit.h>

@class OMUWeatherModel;
@interface OMUMainWeatherCellView : UIView

@property (nonatomic, strong) OMUWeatherModel * weather;
@property (nonatomic, strong) UIImageView * mainWeatherImage;
@property (nonatomic, strong) UILabel * conditionLbl;
@property (nonatomic, strong) UILabel * currentTemperatureLbl;
@property (nonatomic, strong) UILabel * rangeTemperatureLbl;
@property (nonatomic, strong) UILabel * humidityLbl;
@property (nonatomic, strong) UILabel * windInfo;

- (id)initWithWeather:(OMUWeatherModel *) weather;

@end
