//
//  OMUMinorWeatherCellView.m
//  Oh_My_UW
//
//  Created by Eric Lui on 2013-06-08.
//  Copyright (c) 2013 Eric Lui. All rights reserved.
//

#import "OMUMinorWeatherCellView.h"
#import "AFImageRequestOperation.h"
#import "OMURequestConstants.h"

@implementation OMUMinorWeatherCellView

- (id)initWithDayDictionary:(NSDictionary *) dayDict andFrame:(CGRect) frame {
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        _dayDict = dayDict;
        [self setBackgroundColor:[UIColor whiteColor]];
        [self setupMainImage];
        [self setupDrawConstants];
    }
    return self;
}

- (void) drawRect:(CGRect)rect {    
    [[UIColor lightGrayColor] set];
    [[[_dayDict objectForKey:@"Day"] substringToIndex:3] drawInRect:_dateFrame withFont:_dateFont lineBreakMode:NSLineBreakByClipping alignment:NSTextAlignmentCenter];
    
    [[_dayDict objectForKey:@"Low"] drawInRect:_lowFrame withFont:_tempFont lineBreakMode:NSLineBreakByClipping alignment:NSTextAlignmentCenter];
    
    [[UIColor grayColor] set];
    [[_dayDict objectForKey:@"High"] drawInRect:_highFrame withFont:_tempFont lineBreakMode:NSLineBreakByClipping alignment:NSTextAlignmentCenter];
}

- (void) setupDrawConstants {
    _dateFrame = CGRectMake(0, 7.0f, self.frame.size.width, 20.0f);
    _dateFont = [UIFont systemFontOfSize:12.0f];
    
    _lowFrame = CGRectMake(0, 64.0f, self.frame.size.width, 20.0f);
    _highFrame = CGRectMake(0, 52.0f, self.frame.size.width, 20.0f);
    _tempFont = [UIFont systemFontOfSize:10.0f];
}

- (void) setupMainImage {
    _mainWeatherImage = [[UIImageView alloc] initWithFrame:CGRectMake(floor((self.frame.size.width - 30.0f)/2), 25.0f, 30.0f, 26.0f)];
    [self addSubview:_mainWeatherImage];
    [self fetchImage];
}

- (void) fetchImage {
    NSString * url = [_dayDict objectForKey:@"Image"];
    UIImage * img = [[[OMURequestConstants sharedInstance] imageCache] objectForKey:url];
    
    if (img) {
        [_mainWeatherImage setImage:img];
    } else {
        NSURLRequest * request = [[NSURLRequest alloc] initWithURL:[NSURL URLWithString:url]];
        AFImageRequestOperation * operation = [AFImageRequestOperation imageRequestOperationWithRequest:request success:^(UIImage *image) {
            [[[OMURequestConstants sharedInstance] imageCache] setObject:image forKey:url];
            [_mainWeatherImage setImage:image];
        }];
        [operation start];
    }
}
@end
