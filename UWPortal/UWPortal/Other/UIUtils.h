//
//  UIUtils.h
//  UWPortal
//
//  Created by Eric Lui on 12/10/2013.
//  Copyright (c) 2013 Eric Lui. All rights reserved.
//

@interface UIUtils : NSObject

@end

@interface UIColor (CustomColors)

+(UIColor *) mainBackgroundColor;
+(UIColor *) navBarColor;
+(UIColor *) sideMenuColor;

@end

@interface UIImage (Blur)

-(UIImage *)boxblurImageWithBlur:(CGFloat)blur;

@end