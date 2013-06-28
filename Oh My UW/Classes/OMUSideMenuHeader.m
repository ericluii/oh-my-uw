//
//  OMUSideMenuHeader.m
//  Oh_My_UW
//
//  Created by Eric Lui on 2013-06-26.
//  Copyright (c) 2013 Eric Lui. All rights reserved.
//

#import "OMUSideMenuHeader.h"
#import "OMUNavigationConstants.h"

@implementation OMUSideMenuHeader

- (id)initWithTitle:(NSString *) title andImageNamed:(NSString *) imageNamed {
    self = [super initWithReuseIdentifier:[OMUSideMenuHeader reuseIdentifier]];
    if (self) {
        // Initialization code
        [self setFrame:CGRectMake(0, 0, SIDE_MENU_WIDTH, 40.0f)];
        
        _expanded = NO;
        
        _titleLabel = [[UILabel alloc] initWithFrame:self.frame];
        [_titleLabel setText:title];
        [self addSubview:_titleLabel];
        
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(changeExpandedState)];
        [self addGestureRecognizer:tapGesture];
    }
    return self;
}

- (void) collapseMenu {
    _expanded = NO;
}

+ (CGFloat) heightForHeader {
    return 40.0f;
}

+ (NSString *) reuseIdentifier {
    return @"OMUSideMenuHeaderReuseIdentifier";
}

- (void) changeExpandedState {
    _expanded = !_expanded;
    
    if (_expanded) {
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

@end
