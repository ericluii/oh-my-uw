//
//  OMUMainImageCell.h
//  Oh_My_UW
//
//  Created by Eric Lui on 2013-06-15.
//  Copyright (c) 2013 Eric Lui. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum MainCellType {
    schoolOrganizerType = 0,
    directionType,
    socialType,
    newsType,
    faqType,
    numberOfCellType
} MainCellType;

@interface OMUMainImageCell : UITableViewCell {
    UIImage * _cellImage;
    NSString * _cellText;
    CGRect _imageWrapper;
    CGRect _labelWrapper;
    CGRect _shadow;
}

- (id)initWithCellType:(MainCellType) cellType;
+ (NSString *) reuseIdentifier;

@end
