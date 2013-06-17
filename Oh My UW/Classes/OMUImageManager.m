//
//  OMUImageManager.m
//  Oh_My_UW
//
//  Created by Eric Lui on 2013-06-16.
//  Copyright (c) 2013 Eric Lui. All rights reserved.
//

#import "OMUImageManager.h"

@implementation OMUImageManager

+ (OMUImageManager *) sharedInstance {
    static OMUImageManager *sharedInstance = nil;
    static dispatch_once_t oncePredicate;
    dispatch_once(&oncePredicate, ^{
        sharedInstance = [[self alloc] init];
    });
    return sharedInstance;
}

- (UIImage *) getImageNamed:(NSString *) name {
    UIImage * img = [_imageCache objectForKey:name];
    
    if (!img) {
        img = [UIImage imageNamed:name];
        [_imageCache setObject:img forKey:name];
    }
    
    return img;
}

@end
