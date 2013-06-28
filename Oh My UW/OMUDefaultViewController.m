//
//  OMUViewController.m
//  Oh My UW
//
//  Created by Eric Lui on 2013-05-17.
//  Copyright (c) 2013 Eric Lui. All rights reserved.
//

#import "OMUDefaultViewController.h"
#import "OMUDeviceUtils.h"

@interface OMUDefaultViewController ()

@end

@implementation OMUDefaultViewController

- (id)initWithTitle:(NSString *) title {
    self = [super initWithNibName:@"OMUViewController_iPhone" bundle:nil];
    if (self) {
        // Custom initialization
        _sideMenu = [[OMUSideMenu alloc] init];
        [_sideMenu setDelegate:self];
        [self.view addSubview:_sideMenu];
        
        _contentView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
        [self.view addSubview:_contentView];
        
        [self setupGestureRecognizer];
        
        _navBar = [[OMUNavigationBar alloc] initWithTitle:title];
        [_contentView addSubview:_navBar];
    }
    return self;
}

- (void) setBackButtonVisible:(bool) isVisible {
    [_navBar backButtonIsVisisble:isVisible];
}

- (void) setupGestureRecognizer {
    UIPanGestureRecognizer * panDetection = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panHandler:)];
    [_contentView addGestureRecognizer:panDetection];
    
    UISwipeGestureRecognizer * rightSwipeDetection = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(rightSwipeHandler:)];
    [rightSwipeDetection setDirection:UISwipeGestureRecognizerDirectionRight];
    [_contentView addGestureRecognizer:rightSwipeDetection];
    
    UISwipeGestureRecognizer * leftSwipeDetection = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(leftSwipeHandler:)];
    [leftSwipeDetection setDirection:UISwipeGestureRecognizerDirectionLeft];
    [_contentView addGestureRecognizer:leftSwipeDetection];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void) panHandler:(UIPanGestureRecognizer *) recognizer {
    if (recognizer.state == UIGestureRecognizerStateEnded) {
        if (_contentView.frame.origin.x < SIDE_MENU_WIDTH/2) {
            [_navBar setMenuExpanded:NO];
            [UIView animateWithDuration:0.2 animations:^{
                [_contentView setFrame:CGRectMake(0, 0, _contentView.frame.size.width, _contentView.frame.size.height)];
            }];
        } else {
            [_navBar setMenuExpanded:YES];
            [UIView animateWithDuration:0.2 animations:^{
                [_contentView setFrame:CGRectMake(SIDE_MENU_WIDTH, 0, _contentView.frame.size.width, _contentView.frame.size.height)];
            }];
        }
    } else {
        CGPoint translation = [recognizer translationInView:_contentView];
        float newX = _contentView.frame.origin.x + translation.x;
        
        if (newX > SIDE_MENU_WIDTH || newX < 0) {
            return;
        }
        
        [_contentView setFrame:CGRectMake(newX, 0, _contentView.frame.size.width, _contentView.frame.size.height)];
        [recognizer setTranslation:CGPointMake(0, 0) inView:_contentView];
    }
}

- (void) leftSwipeHandler:(UISwipeGestureRecognizer *) recognizer {
    [_navBar setMenuExpanded:NO];
    [UIView animateWithDuration:0.2 animations:^{
        [_contentView setFrame:CGRectMake(0, 0, _contentView.frame.size.width, _contentView.frame.size.height)];
    }];
}

- (void) rightSwipeHandler:(UISwipeGestureRecognizer *) recognizer {
    [_navBar setMenuExpanded:YES];
    [UIView animateWithDuration:0.2 animations:^{
        [_contentView setFrame:CGRectMake(SIDE_MENU_WIDTH, 0, _contentView.frame.size.width, _contentView.frame.size.height)];
    }];
}

+(CGRect)viewFrame {
    return CGRectMake(0, [OMUDeviceUtils isIOS7] ? STATUS_BAR_HEIGHT + NAV_BAR_HEIGHT : NAV_BAR_HEIGHT, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height - NAV_BAR_HEIGHT - STATUS_BAR_HEIGHT);
}

- (void) popAllControllersAndPush:(UIViewController *) controller {
    [_navBar setMenuExpanded:NO];
    [UIView animateWithDuration:0.2 animations:^{
        [_contentView setFrame:CGRectMake(0, 0, _contentView.frame.size.width, _contentView.frame.size.height)];
    }];
    [self.navigationController popToRootViewControllerAnimated:NO];
    [self.navigationController pushViewController:controller animated:YES];
}

- (void) popAllControllersToRoot {
    [_navBar setMenuExpanded:NO];
    [UIView animateWithDuration:0.2 animations:^{
        [_contentView setFrame:CGRectMake(0, 0, _contentView.frame.size.width, _contentView.frame.size.height)];
    }];
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (void) pushViewController:(UIViewController *) controller {
    [_navBar setMenuExpanded:NO];
    [UIView animateWithDuration:0.2 animations:^{
        [_contentView setFrame:CGRectMake(0, 0, _contentView.frame.size.width, _contentView.frame.size.height)];
    }];
    [self.navigationController pushViewController:controller animated:YES];
}

@end
