//
//  SideMenuView.m
//  UWPortal
//
//  Created by Eric Lui on 12/10/2013.
//  Copyright (c) 2013 Eric Lui. All rights reserved.
//

#import "SideMenuView.h"
#import "UIUtils.h"

@implementation SideMenuView

- (id)initWithMenuDelegate:(id) delegate {
    NSInteger width = CGRectGetWidth([[UIScreen mainScreen] bounds]) - 60;
    self = [super initWithFrame:CGRectMake(-width,
                                           0,
                                           width,
                                           CGRectGetHeight([[UIScreen mainScreen] bounds]))];
    if (self) {
        // Initialization code
        _menu = [[UITableView alloc] initWithFrame:CGRectMake(0,
                                                              20,
                                                              width,
                                                              CGRectGetHeight([[UIScreen mainScreen] bounds]) - 20)];
        [_menu setBackgroundColor:[UIColor clearColor]];
        [_menu setDelegate:delegate];
        [_menu setDataSource:delegate];
        [self addSubview:_menu];
        [self setBackgroundColor:[UIColor clearColor]];
        
        // Add frost effect
        _blurBackground = [[UIImageView alloc] initWithFrame:CGRectMake(width,
                                                                        0,
                                                                        0,
                                                                        CGRectGetHeight([[UIScreen mainScreen] bounds]))];
        [_blurBackground setContentMode:UIViewContentModeLeft];
        [_blurBackground setClipsToBounds:YES];
        [_blurBackground setImage:[self getBlurredImage]];
        [self insertSubview:_blurBackground atIndex:0];
        
        UIPanGestureRecognizer * panDetection = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panHandler:)];
        [self addGestureRecognizer:panDetection];
    }
    return self;
}

- (void) panHandler:(UIPanGestureRecognizer *) recognizer {
    if (recognizer.state == UIGestureRecognizerStateBegan) {
        [_blurBackground setImage:[self getBlurredImage]];
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
            }];
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
        [recognizer setTranslation:CGPointMake(0, 0) inView:self];
    }
}

- (UIImage*)getBlurredImage {
    // x, y and size variables below are only examples.
    // You will want to calculate this in code based on the view you will be presenting.
    float x = 0;
    float y = 0;
    CGSize size = CGSizeMake(self.frame.size.width,self.frame.size.height);
    
    if (size.width == 0) {
        return nil;
    }
    
    UIGraphicsBeginImageContext(size);
    CGContextRef c = UIGraphicsGetCurrentContext();
    CGContextTranslateCTM(c, -x, -y);
    
    CALayer* lyer = ((UIViewController*)_menu.delegate).view.layer;
    [lyer addSublayer:((UIViewController*)_menu.delegate).navigationController.navigationBar.layer];
    [lyer renderInContext:c]; // view is the view you are grabbing the screen shot of. The view that is to be blurred.
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
        sectionHeaderTitles = @[@"Home",
                                @"School Organizer",
                                @"Directions",
                                @"Social Feeds",
                                @"Other Stuff"];
    });
    
    return sectionHeaderTitles;
}

+ (NSArray * const) sectionRowTitles {
    static NSArray *sectionRowTitles = nil;
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        sectionRowTitles = @[@[],
                             @[@"Courses", @"Exam Schedule"], // @"School Planner",  @"UW Learn", @"Jobmine", @"Quest", @"Assignments", @"Midterms",
                             @[@"Campus", @"Food", @"Study Spots", @"Parking"], // @"Around the City"
                             @[@"Suggestions", @"About the App"],
                             @[@"Reddit UW", @"Twitter", @"Goose Watch", @"Events"]]; // News
    });
    
    return sectionRowTitles;
}

@end
