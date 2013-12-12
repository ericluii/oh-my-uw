//
//  SideMenuHeaderView.m
//  UWPortal
//
//  Created by Eric Lui on 12/11/2013.
//  Copyright (c) 2013 Eric Lui. All rights reserved.
//

#import "SideMenuHeaderView.h"
#import "UIUtils.h"

@implementation SideMenuHeaderView

- (id)initWithSectionNumber:(NSInteger)sectionNumber {
    self =[super initWithReuseIdentifier:[SideMenuHeaderView reuseIdentifier]];
    
    if (self) {
        // Initialization code
        _section = sectionNumber;
        _isOpen = NO;
        
        [self setFrame:CGRectMake(0,
                                  0,
                                  CGRectGetWidth([[UIScreen mainScreen] bounds]) - 50,
                                  50)];
        [self setBackgroundView:[[UIView alloc] initWithFrame:self.frame]];
        [self.backgroundView setBackgroundColor:[UIColor colorWithWhite:0.5 alpha:0.3]];
        
        _headerTitle = [[UILabel alloc] initWithFrame:CGRectMake(10, 5, 320, 40)];
        _headerTitle.font = [UIFont systemFontOfSize:20.0f];
        [self addSubview:_headerTitle];
        
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                                     action:@selector(changeExpandedState)];
        [self addGestureRecognizer:tapGesture];
    }
    return self;
}

- (void) changeExpandedState {
    _isOpen = !_isOpen;
    
    if (_isOpen) {
        if ([self.delegate respondsToSelector:@selector(sectionHeaderView:sectionOpened:)]) {
            [self.delegate sectionHeaderView:self sectionOpened:self.section];
        }
    }
    else {
        if ([self.delegate respondsToSelector:@selector(sectionHeaderView:sectionClosed:)]) {
            [self.delegate sectionHeaderView:self sectionClosed:self.section];
        }
    }
}

- (void) toggleOpenState {
    _isOpen = !_isOpen;
}

+ (NSInteger)headerHeight {
    return 50;
}

+ (NSString*)reuseIdentifier {
    return @"SideMenuHeaderViewReuseIdentifier";
}

@end
