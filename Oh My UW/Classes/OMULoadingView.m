//
//  OMULoadingView.m
//  Oh_My_UW
//
//  Created by Eric Lui on 2013-07-27.
//  Copyright (c) 2013 Eric Lui. All rights reserved.
//

#import "OMULoadingView.h"
#import "OMUUIUtils.h"
#import "OMUNavigationConstants.h"
#import "OMUImageManager.h"

@implementation OMULoadingView

- (id)init {
    self = [super initWithFrame:[OMUUIUtils fullscreenFrame]];
    if (self) {
        // Initialization code
        [self setBackgroundColor:[UIColor whiteColor]];
        [self setupLoadingBar];
        [self setupRetryButton];
    }
    return self;
}

#pragma mark - Setup Methods

- (void) setupLoadingBar {
    CGRect barFrame = CGRectMake(0, floor(self.frame.size.height/3)*2, 320.0f, 10.0f);
    
    UIImage *statusImage = [[OMUImageManager sharedInstance] getImageNamed:@"loading_bar_1.png"];
    _activityImageView = [[UIImageView alloc]
                         initWithImage:statusImage];
    
    _activityImageView.animationImages = [NSArray arrayWithObjects:
                                         [[OMUImageManager sharedInstance] getImageNamed:@"loading_bar_1.png"],
                                         [[OMUImageManager sharedInstance] getImageNamed:@"loading_bar_2.png"],
                                         [[OMUImageManager sharedInstance] getImageNamed:@"loading_bar_3.png"],
                                         [[OMUImageManager sharedInstance] getImageNamed:@"loading_bar_4.png"],
                                         [[OMUImageManager sharedInstance] getImageNamed:@"loading_bar_5.png"],
                                         [[OMUImageManager sharedInstance] getImageNamed:@"loading_bar_6.png"],
                                         [[OMUImageManager sharedInstance] getImageNamed:@"loading_bar_7.png"],
                                         [[OMUImageManager sharedInstance] getImageNamed:@"loading_bar_8.png"],
                                         [[OMUImageManager sharedInstance] getImageNamed:@"loading_bar_9.png"],
                                         [[OMUImageManager sharedInstance] getImageNamed:@"loading_bar_10.png"],
                                         nil];
    
    _activityImageView.animationDuration = 0.4;
    [_activityImageView setFrame:barFrame];
    [_activityImageView setHidden:YES];
    
    _errorImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"error_bar"]];
    [_errorImageView setFrame:barFrame];
    
    _messageLbl = [[UILabel alloc] init];
    [_messageLbl setNumberOfLines:0];
    [_messageLbl setLineBreakMode:NSLineBreakByWordWrapping];
    [_messageLbl setBackgroundColor:[UIColor clearColor]];
    [_messageLbl setTextColor:[UIColor grayColor]];
    [_messageLbl setFont:[UIFont systemFontOfSize:14.0f]];
    
    [self addSubview:_activityImageView];
    [self addSubview:_errorImageView];
    [self addSubview:_messageLbl];
}

- (void) setupRetryButton {
    CGFloat thirdOfScreen = floor(self.frame.size.width)/3;
    _retryBtn = [[UIButton alloc] initWithFrame:CGRectMake(thirdOfScreen, _errorImageView.frame.origin.y + 20.0f, thirdOfScreen, 30.0f)];
    [_retryBtn setBackgroundColor:[UIColor blackColor]];
    [_retryBtn addTarget:self action:@selector(retryButtonPressed) forControlEvents:UIControlEventTouchUpInside];
    [_retryBtn setHidden:YES];
    
    [self addSubview:_retryBtn];
}

#pragma mark - Button Event Methods

- (void) retryButtonPressed {
    if ([_delegate respondsToSelector:@selector(loadingViewRetryButtonPressed)]) {
        [_delegate loadingViewRetryButtonPressed];
    }
}

#pragma mark - UI Display Methods

- (void) showLoadscreenWithMessage:(NSString *) message andError:(bool) isError {
    [self setHidden:NO];
    
    [_errorImageView setHidden:!isError];
    [_activityImageView setHidden:isError];
    [_retryBtn setHidden:(_delegate ? !isError : YES)];
    
    CGSize maxSize = CGSizeMake(self.frame.size.width - 10.0f, _activityImageView.frame.origin.y);
    CGSize textWrapperSize = [message sizeWithFont:[UIFont systemFontOfSize:14.0f]
                                      constrainedToSize:maxSize
                                          lineBreakMode:NSLineBreakByWordWrapping];
    
    [_messageLbl setFrame:CGRectMake(5.0f, _activityImageView.frame.origin.y - textWrapperSize.height, 315.0f, textWrapperSize.height)];
    [_messageLbl setText:message];
    
    if (!isError) {
        [_activityImageView startAnimating];
    }
}

- (void) hideLoadingMessage {
    [self setHidden:YES];
}

@end
