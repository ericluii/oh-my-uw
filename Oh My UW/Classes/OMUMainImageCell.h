//
//  OMUMainImageCell.h
//  Oh_My_UW
//
//  Created by Eric Lui on 2013-06-15.
//  Copyright (c) 2013 Eric Lui. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OMUDefaultCellWrapper.h"

typedef enum MainCellType {
    schoolOrganizerType = 0,
    directionType,
    socialType,
    newsType,
    faqType,
    numberOfCellType
} MainCellType;

@interface OMUMainImageCell : UITableViewCell

@property (nonatomic, strong) OMUDefaultCellWrapper * wrapper;
@property (nonatomic, strong) UIImageView * backgroundImage;
@property (nonatomic, strong) UILabel * overlayText;

- (id)initWithCellType:(MainCellType) cellType;
+ (NSString *) reuseIdentifier;

@end
