//
//  OMUViewController.m
//  Oh My UW
//
//  Created by Eric Lui on 2013-05-17.
//  Copyright (c) 2013 Eric Lui. All rights reserved.
//

#import "OMUDefaultViewController.h"

@interface OMUDefaultViewController ()

@end

@implementation OMUDefaultViewController

- (id)initWithTitle:(NSString *) title {
    self = [super initWithNibName:@"OMUViewController_iPhone" bundle:nil];
    if (self) {
        // Custom initialization
        _sideMenu = [[OMUSideMenu alloc] init];
        [self.view addSubview:_sideMenu];
        
        UIView *view = [[UIView alloc] initWithFrame:[OMUDefaultViewController viewFrame]];
        [view setBackgroundColor: [UIColor whiteColor]];
        [self.view addSubview:view];
        
        [self setupGestureRecognizer];
        
        _navBar = [[OMUNavigationBar alloc] initWithTitle:title];
        [self.view addSubview:_navBar];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void) setupGestureRecognizer {
    UIPanGestureRecognizer * panDetection = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panHandler:)];
    [self.view addGestureRecognizer:panDetection];
    
    UISwipeGestureRecognizer * rightSwipeDetection = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(rightSwipeHandler:)];
    [rightSwipeDetection setDirection:UISwipeGestureRecognizerDirectionRight];
    [self.view addGestureRecognizer:rightSwipeDetection];
    
    UISwipeGestureRecognizer * leftSwipeDetection = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(leftSwipeHandler:)];
    [leftSwipeDetection setDirection:UISwipeGestureRecognizerDirectionLeft];
    [self.view addGestureRecognizer:leftSwipeDetection];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void) panHandler:(UIPanGestureRecognizer *) recognizer {
    if (recognizer.state == UIGestureRecognizerStateEnded) {
        if (self.view.frame.origin.x < SIDE_MENU_WIDTH/2) {
            [_navBar setMenuExpanded:NO];
            [UIView animateWithDuration:0.2 animations:^{
                [self.view.subviews[0] setFrame:CGRectMake(0, 0, SIDE_MENU_WIDTH, self.view.frame.size.height)];
                [self.view setFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
            }];
        } else {
            [_navBar setMenuExpanded:YES];
            [UIView animateWithDuration:0.2 animations:^{
                [self.view.subviews[0] setFrame:CGRectMake(-SIDE_MENU_WIDTH, 0, SIDE_MENU_WIDTH, self.view.frame.size.height)];
                [self.view setFrame:CGRectMake(SIDE_MENU_WIDTH, 0, self.view.frame.size.width, self.view.frame.size.height)];
            }];
        }
    } else {
        CGPoint translation = [recognizer translationInView:self.view];
        float newX = self.view.frame.origin.x + translation.x;
        
        if (newX > SIDE_MENU_WIDTH || newX < 0) {
            return;
        }
        
        [[self.view.subviews objectAtIndex:0] setFrame:CGRectMake(-newX, 0, self.view.frame.size.width, self.view.frame.size.height)];
        self.view.frame = CGRectMake(newX, 0, self.view.frame.size.width, self.view.frame.size.height);
        [recognizer setTranslation:CGPointMake(0, 0) inView:self.view];
    }
}

- (void) leftSwipeHandler:(UISwipeGestureRecognizer *) recognizer {
    [_navBar setMenuExpanded:NO];
    [UIView animateWithDuration:0.2 animations:^{
        [self.view.subviews[0] setFrame:CGRectMake(0, 0, SIDE_MENU_WIDTH, self.view.frame.size.height)];
        [self.view setFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    }];
}

- (void) rightSwipeHandler:(UISwipeGestureRecognizer *) recognizer {
    [_navBar setMenuExpanded:YES];
    [UIView animateWithDuration:0.2 animations:^{
        [self.view.subviews[0] setFrame:CGRectMake(-SIDE_MENU_WIDTH, 0, SIDE_MENU_WIDTH, self.view.frame.size.height)];
        [self.view setFrame:CGRectMake(SIDE_MENU_WIDTH, 0, self.view.frame.size.width, self.view.frame.size.height)];
    }];
}

+(CGRect)viewFrame {
    return CGRectMake(0, NAV_BAR_HEIGHT, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height - NAV_BAR_HEIGHT);
}

@end
