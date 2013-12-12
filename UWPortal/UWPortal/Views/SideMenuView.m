//
//  SideMenuView.m
//  UWPortal
//
//  Created by Eric Lui on 12/10/2013.
//  Copyright (c) 2013 Eric Lui. All rights reserved.
//

#import "SideMenuView.h"
#import "SideMenuHeaderView.h"
#import "UIUtils.h"
#import "HomeViewController.h"
#import "ExamScheduleViewController.h"
#import "AppDelegate.h"

@implementation SideMenuView

- (id)initWithViewController:(UIViewController*)vc {
    NSInteger width = CGRectGetWidth([[UIScreen mainScreen] bounds]) - 50;
    self = [super initWithFrame:CGRectMake(-width,
                                           0,
                                           width,
                                           CGRectGetHeight([[UIScreen mainScreen] bounds]))];
    if (self) {
        // Initialization code
        _ownerViewController = vc;
        
        // Setup blocking view
        _blockingView = [[UIView alloc] initWithFrame:CGRectMake(width,
                                                                 0,
                                                                 CGRectGetWidth([[UIScreen mainScreen] bounds]),
                                                                 CGRectGetHeight([[UIScreen mainScreen] bounds]))];
        [_blockingView setBackgroundColor:[UIColor blackColor]];
        [_blockingView setAlpha:0];
        [self addSubview:_blockingView];
        
        // Setup Side Menu
        UIView *statusCover = [[UIView alloc] initWithFrame:CGRectMake(0, 0, width, 64)];
        [statusCover setBackgroundColor:[UIColor sideMenuColor]];
        [statusCover setAlpha:0.3];
        [self addSubview:statusCover];
        
        _menu = [[UITableView alloc] initWithFrame:CGRectMake(0,
                                                              64,
                                                              width,
                                                              CGRectGetHeight([[UIScreen mainScreen] bounds]) - 64)];
        [_menu setBackgroundColor:[UIColor clearColor]];
        [_menu setSeparatorInset:UIEdgeInsetsZero];
        [_menu setDelegate:self];
        [_menu setDataSource:self];
        _menu.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
        [self addSubview:_menu];
        [self setBackgroundColor:[UIColor clearColor]];
        
        // Add frost effect
        _blurBackground = [[UIImageView alloc] initWithFrame:CGRectMake(width,
                                                                        0,
                                                                        0,
                                                                        CGRectGetHeight([[UIScreen mainScreen] bounds]))];
        [_blurBackground setContentMode:UIViewContentModeLeft];
        [_blurBackground setClipsToBounds:YES];
        [self insertSubview:_blurBackground atIndex:0];
        
        UIPanGestureRecognizer * panDetection = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panHandler:)];
        [self addGestureRecognizer:panDetection];
    }
    return self;
}

- (void) panHandler:(UIPanGestureRecognizer *) recognizer {
    if (recognizer.state == UIGestureRecognizerStateBegan) {
        [_blurBackground setImage:[self getBlurredImage]];
        [_ownerViewController.view setUserInteractionEnabled:NO];
    }
    
    if (recognizer.state == UIGestureRecognizerStateEnded) {
        CGPoint vel = [recognizer velocityInView:self];
        if (vel.x < 0) {
            [UIView animateWithDuration:(vel.x < -500 ? 0.2 : 0.4) animations:^{
                [self setFrame:CGRectMake(-CGRectGetWidth(self.frame),
                                                   0,
                                                   self.frame.size.width,
                                                   self.frame.size.height)];
                [_blurBackground setFrame:CGRectMake(CGRectGetWidth(self.frame),
                                                    0,
                                                    0,
                                                     self.frame.size.height)];
                [_blockingView setAlpha:0];
            }];
            
            [_ownerViewController.view setUserInteractionEnabled:YES];
        } else {
            [UIView animateWithDuration:(vel.x > 500 ? 0.2 : 0.4) animations:^{
                [self setFrame:CGRectMake(0,
                                                   0,
                                                   self.frame.size.width,
                                                   self.frame.size.height)];
                [_blurBackground setFrame:CGRectMake(0,
                                                     0,
                                                     CGRectGetWidth(self.frame),
                                                     self.frame.size.height)];
                [_blockingView setAlpha:0.6];
            }];
        }
    } else {
        CGPoint translation = [recognizer translationInView:self];
        float newX = self.frame.origin.x + translation.x;
        if (newX < -CGRectGetWidth(self.frame) || newX > 0) {
            return;
        }
        
        [self setFrame:CGRectMake(newX, 0, self.frame.size.width, self.frame.size.height)];
        [_blurBackground setFrame:CGRectMake(-newX, 0, CGRectGetWidth(self.frame) + newX, self.frame.size.height)];
        [_blockingView setAlpha:((CGRectGetWidth(self.frame) + newX)/CGRectGetWidth(self.frame))*0.6];
        [recognizer setTranslation:CGPointMake(0, 0) inView:self];
    }
}

- (UIImage*)getBlurredImage {
    // x, y and size variables below are only examples.
    // You will want to calculate this in code based on the view you will be presenting.
    float x = 0;
    float y = 0;
    CGSize size = self.frame.size;
    
    UIGraphicsBeginImageContext(size);
    CGContextRef c = UIGraphicsGetCurrentContext();
    CGContextTranslateCTM(c, -x, -y);
    
    [((UIWindow*)[[[UIApplication sharedApplication] windows] lastObject]).layer renderInContext:c];
    // view is the view you are grabbing the screen shot of. The view that is to be blurred.
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    NSData *imageData = UIImageJPEGRepresentation(image, 1); // convert to jpeg
    image = [UIImage imageWithData:imageData];
    return [image boxblurImageWithBlur:0.2f];
}

+ (NSArray * const) sectionHeaderTitles {
    static NSArray *sectionHeaderTitles = nil;
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        sectionHeaderTitles = @[@"School Organizer",
                                @"Directions",
                                @"Social Feeds"];//,
                                //@"Other Stuff"];
    });
    
    return sectionHeaderTitles;
}

+ (NSArray * const) sectionRowTitles {
    static NSArray *sectionRowTitles = nil;
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        sectionRowTitles = @[@[@"Courses", @"Exam Schedule"], // @"School Planner",  @"UW Learn", @"Jobmine", @"Quest", @"Assignments", @"Midterms",
                             @[@"Campus", @"Food", @"Study Spots", @"Parking"], // @"Around the City"
                             @[@"Suggestions", @"About the App"]];//,
                             //@[@"Reddit UW", @"Twitter", @"Goose Watch", @"Events"]]; // News
    });
    
    return sectionRowTitles;
}

#pragma mark - Tableview Delegate and Datasource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return numberOfCellType;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [[[SideMenuView sectionRowTitles] objectAtIndex:section] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"bob"];
    
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"bob"];
        [cell setBackgroundColor:[UIColor clearColor]];
        [cell setBackgroundView:[[UIView alloc] initWithFrame:cell.frame]];
        [cell.backgroundView setBackgroundColor:[UIColor sideMenuColor]];
        [cell.backgroundView setAlpha:0.1];
    }
    
    [cell.textLabel setText:[[[SideMenuView sectionRowTitles]
                              objectAtIndex:indexPath.section]
                             objectAtIndex:indexPath.row]];
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return [SideMenuHeaderView headerHeight];
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    SideMenuHeaderView * header = [tableView dequeueReusableCellWithIdentifier:[SideMenuHeaderView reuseIdentifier]];
    
    if (!header) {
        header = [[SideMenuHeaderView alloc] initWithSectionNumber:section];
    }
    
    [header.textLabel setText:[[SideMenuView sectionHeaderTitles] objectAtIndex:section]];
    
    return header;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [UIView animateWithDuration:(0.3) animations:^{
        [self setFrame:CGRectMake(-CGRectGetWidth(self.frame),
                                  0,
                                  self.frame.size.width,
                                  self.frame.size.height)];
        [_blurBackground setFrame:CGRectMake(CGRectGetWidth(self.frame),
                                             0,
                                             0,
                                             self.frame.size.height)];
        [_blockingView setAlpha:0];
    }];
    [_ownerViewController.view setUserInteractionEnabled:YES];
    
    [_ownerViewController.navigationController popToRootViewControllerAnimated:NO];
    [[[AppDelegate appDelegate] rootViewController].navigationController pushViewController:[[ExamScheduleViewController alloc] init] animated:YES];
}

@end
