//
//  OMULoadingView.h
//  Oh_My_UW
//
//  Created by Eric Lui on 2013-07-27.
//  Copyright (c) 2013 Eric Lui. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol OMULoadingViewDelegate <NSObject>

@optional
- (void) loadingViewRetryButtonPressed;

@end

@interface OMULoadingView : UIView {
    UIImageView * _activityImageView;
    UIImageView * _errorImageView;
    UILabel * _messageLbl;
    UIButton * _retryBtn;
}

@property (nonatomic, strong) id<OMULoadingViewDelegate> delegate;

- (void) showLoadscreenWithMessage:(NSString *) message andError:(bool) isError;
- (void) hideLoadingMessage;

@end