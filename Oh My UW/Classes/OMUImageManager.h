//
//  OMUImageManager.h
//  Oh_My_UW
//
//  Created by Eric Lui on 2013-06-16.
//  Copyright (c) 2013 Eric Lui. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OMUImageManager : NSObject {
    NSMutableDictionary * _imageCache;
}

+ (OMUImageManager *) sharedInstance;
- (UIImage *) getImageNamed:(NSString *) name;

@end
