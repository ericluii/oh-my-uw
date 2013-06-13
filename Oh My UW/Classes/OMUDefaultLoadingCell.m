//
//  OMUDefaultLoadingCell.m
//  Oh_My_UW
//
//  Created by Eric Lui on 2013-06-12.
//  Copyright (c) 2013 Eric Lui. All rights reserved.
//

#import "OMUDefaultLoadingCell.h"
#import "OMUNavigationConstants.h"

@implementation OMUDefaultLoadingCell

- (id)initWithHeight:(CGFloat) height andText:(NSString *) text {
    self = [super initWithFrame:CGRectMake(0.0f, 0.0f, 320.0f, height)];
    if (self) {
        // Initialization code
        [self setSelectionStyle:UITableViewCellSelectionStyleNone];
        [self configureWithText:text];
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

+ (NSString *) reuseIdentifier {
    return @"OMUDefaultLoadingCellIdentifier";
}

- (void) configureWithText:(NSString *)text {
    _wrapper = [[OMUDefaultCellWrapper alloc] initWithFrame:CGRectMake(WRAPPER_OFFSET, WRAPPER_OFFSET, 320.0f - (WRAPPER_OFFSET * 2), WEATHER_CELL_HEIGHT - (WRAPPER_OFFSET * 2))];
    
    UIImage *statusImage = [UIImage imageNamed:@"loading_bar_1.png"];
    UIImageView *activityImageView = [[UIImageView alloc]
                                      initWithImage:statusImage];
    
    activityImageView.animationImages = [NSArray arrayWithObjects:
                                         [UIImage imageNamed:@"loading_bar_1.png"],
                                         [UIImage imageNamed:@"loading_bar_2.png"],
                                         [UIImage imageNamed:@"loading_bar_3.png"],
                                         [UIImage imageNamed:@"loading_bar_4.png"],
                                         [UIImage imageNamed:@"loading_bar_5.png"],
                                         [UIImage imageNamed:@"loading_bar_6.png"],
                                         [UIImage imageNamed:@"loading_bar_7.png"],
                                         [UIImage imageNamed:@"loading_bar_8.png"],
                                         [UIImage imageNamed:@"loading_bar_9.png"],
                                         [UIImage imageNamed:@"loading_bar_10.png"],
                                         nil];
    
    activityImageView.animationDuration = 0.4;
    [activityImageView setFrame:CGRectMake(0, _wrapper.frame.size.height - 20.0f, _wrapper.frame.size.width, 10.0f)];
    [activityImageView startAnimating];
    [_wrapper addSubview:activityImageView];
    
    UILabel * loadingText = [[UILabel alloc] initWithFrame:CGRectMake(0, _wrapper.frame.size.height - 35.0f, _wrapper.frame.size.width, 15.0f)];
    [loadingText setText:text];
    [loadingText setFont:[UIFont systemFontOfSize:12.0f]];
    [loadingText setTextAlignment:NSTextAlignmentCenter];
    [loadingText setTextColor:[UIColor grayColor]];
    [_wrapper addSubview:loadingText];
    
    [self addSubview:_wrapper];
}

@end
