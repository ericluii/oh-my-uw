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

- (void)viewDidLoad {
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    _sideMenu = [[OMUSideMenu alloc] init];
    [self.view addSubview:_sideMenu];
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, NAV_BAR_HEIGHT, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height - 44)];
    [view setBackgroundColor:[UIColor colorWithRed:(rand()%255 + 100)/255.0 green:(rand()%255 + 100)/255.0 blue:(rand()%255 + 100)/255.0 alpha:1]];
    [self.view addSubview:view];
    
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(100, 100, 200, 100)];
    [button setBackgroundColor:[UIColor purpleColor]];
    [button addTarget:self action:@selector(touch) forControlEvents:UIControlEventTouchDown];
    [self.view addSubview:button];
    
    UIButton *button2 = [[UIButton alloc] initWithFrame:CGRectMake(100, 300, 200, 100)];
    [button2 setBackgroundColor:[UIColor redColor]];
    [button2 addTarget:self action:@selector(touch2) forControlEvents:UIControlEventTouchDown];
    [self.view addSubview:button2];
    
    _navBar = [[OMUNavigationBar alloc] initWithTitle:[NSString stringWithFormat:@"Title %d", rand() % 999]];
    [self.view addSubview:_navBar];
}

- (void) setupGestureRecognizer {
    UISwipeGestureRecognizer * swipeDetection = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(didSwipe:)];
    [swipeDetection setDirection:UISwipeGestureRecognizerDirectionLeft|UISwipeGestureRecognizerDirectionRight];
    [self.view addGestureRecognizer:swipeDetection];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)touch {    
    OMUDefaultViewController *vc = [[OMUDefaultViewController alloc] initWithNibName:@"OMUViewController_iPhone" bundle:nil];
    [_navBar pushViewController:vc animated:YES];
}

-(void)touch2 {
    [_navBar popViewControllerAndAnimated:YES];
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [touches anyObject];
    _touchStarted = [touch locationInView:self.parentViewController.view];
}

-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [touches anyObject];
    CGPoint nextTouchPoint = [touch locationInView:self.parentViewController.view];
    float xOffset = nextTouchPoint.x - _touchStarted.x;
    _touchStarted.x = nextTouchPoint.x;
    float newX = self.view.frame.origin.x + xOffset;
    
    if (newX > SIDE_MENU_WIDTH || newX < 0) {
        return;
    }
    
    [[self.view.subviews objectAtIndex:0] setFrame:CGRectMake(-newX, 0, self.view.frame.size.width, self.view.frame.size.height)];
    self.view.frame = CGRectMake(newX, 0, self.view.frame.size.width, self.view.frame.size.height);
}

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
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
}

@end
