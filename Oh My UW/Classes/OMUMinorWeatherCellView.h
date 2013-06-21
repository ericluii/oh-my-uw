//
//  OMUMinorWeatherCellView.h
//  Oh_My_UW
//
//  Created by Eric Lui on 2013-06-08.
//  Copyright (c) 2013 Eric Lui. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OMUMinorWeatherCellView : UIView

@property (nonatomic, strong) NSDictionary *dayDict;
@property (nonatomic, strong) UIImageView * mainWeatherImage;

- (id)initWithDayDictionary:(NSDictionary *) dayDict andFrame:(CGRect) frame;

@end
