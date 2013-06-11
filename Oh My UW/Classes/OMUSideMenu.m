//
//  OMUSideMenu.m
//  Oh_My_UW
//
//  Created by Eric Lui on 2013-05-30.
//  Copyright (c) 2013 Eric Lui. All rights reserved.
//

#import "OMUSideMenu.h"
#import "OMUNavigationConstants.h"

@implementation OMUSideMenu

- (id)init {
    self = [super initWithFrame:CGRectMake(0, 0, SIDE_MENU_WIDTH, [UIScreen mainScreen].bounds.size.height)];
    if (self) {
        // Initialization code
        [self setupMenu];
    }
    return self;
}

- (void) setupMenu {
    _menu = [[UITableView alloc] initWithFrame:self.frame];
    [_menu setDelegate:self];
    [_menu setDataSource:self];
    [_menu setUserInteractionEnabled:YES];
    [_menu setScrollEnabled:YES];
    [self addSubview:_menu];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 4;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"menuCell"];
    
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithFrame:CGRectMake(0, 0, SIDE_MENU_WIDTH, 50.0f)];
    }
    
    [cell.textLabel setText:[NSString stringWithFormat:@"Menu Item %d", indexPath.row]];
    
    return cell;
}
@end
