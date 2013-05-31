//
//  OMUViewController.m
//  Oh My UW
//
//  Created by Eric Lui on 2013-05-17.
//  Copyright (c) 2013 Eric Lui. All rights reserved.
//

#import "OMUDefaultViewController.h"
#import "OMUAppDelegate.h"

@interface OMUDefaultViewController ()

@end

@implementation OMUDefaultViewController

- (void)viewDidLoad {
    touchTolerance = 20;
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    [self.view addSubview:((OMUAppDelegate *)[[UIApplication sharedApplication] delegate]).sideMenu];
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 44, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height - 44)];
    [view setBackgroundColor:[UIColor greenColor]];
    [self.view addSubview:view];
    
    UIView *menuDetection = [[UIView alloc] initWithFrame:CGRectMake(0, 44, 20, [UIScreen mainScreen].bounds.size.height - 44)];
    [menuDetection setBackgroundColor:[UIColor redColor]];
    [self.view addSubview:menuDetection];
    
    [self.view addSubview:((OMUAppDelegate *)[[UIApplication sharedApplication] delegate]).navBar];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [touches anyObject];
    CGPoint point = [touch locationInView:self.parentViewController.view];
    
    if ([touch locationInView:self.view].x > touchTolerance || point.x >= 240) {
        return;
    }
    
    touchTolerance = [UIScreen mainScreen].bounds.size.width;
    
    [[self.view.subviews objectAtIndex:0] setFrame:CGRectMake(-point.x, 0, self.view.frame.size.width, self.view.frame.size.height)];
    self.view.frame = CGRectMake(point.x, 0, self.view.frame.size.width, self.view.frame.size.height);
}

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [touches anyObject];
    CGPoint point = [touch locationInView:self.parentViewController.view];

    if (point.x < 120) {
        [UIView animateWithDuration:0.2 animations:^{
            [self.view.subviews[0] setFrame:CGRectMake(0, 0, 240, self.view.frame.size.height)];
            [self.view setFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
        }];
    } else {
        [UIView animateWithDuration:0.2 animations:^{
            [self.view.subviews[0] setFrame:CGRectMake(-240, 0, 240, self.view.frame.size.height)];
            [self.view setFrame:CGRectMake(240, 0, self.view.frame.size.width, self.view.frame.size.height)];
        }];
    }
    
    touchTolerance = 20;
}

@end
