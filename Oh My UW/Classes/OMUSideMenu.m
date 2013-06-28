//
//  OMUSideMenu.m
//  Oh_My_UW
//
//  Created by Eric Lui on 2013-05-30.
//  Copyright (c) 2013 Eric Lui. All rights reserved.
//

#import "OMUSideMenu.h"
#import "OMUNavigationConstants.h"
#import "OMUDeviceUtils.h"
#import "OMUSideMenuHeader.h"

@implementation OMUSideMenu

- (id)init {
    self = [super initWithFrame:CGRectMake(0, [OMUDeviceUtils isIOS7] ? STATUS_BAR_HEIGHT : 0, SIDE_MENU_WIDTH, [UIScreen mainScreen].bounds.size.height - ([OMUDeviceUtils isIOS7] ? STATUS_BAR_HEIGHT * 2 : 0))];
    if (self) {
        // Initialization code
        [self setupMenu];
        _openSectionIndex = NSNotFound;
    }
    return self;
}

- (void) setupMenu {
    _menu = [[UITableView alloc] initWithFrame:self.frame];
    [_menu setDelegate:self];
    [_menu setDataSource:self];
    [_menu setTableFooterView:[[UIView alloc] initWithFrame:CGRectZero]];
    [_menu setBackgroundColor:[UIColor colorWithRed:64/255.0 green:64/255.0 blue:64/255.0 alpha:1]];
    [self addSubview:_menu];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 5;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section != _openSectionIndex) {
        return 0;
    }
    
    switch (section) {
        case sectionTypeHome:
            return 0;
        case sectionTypeSchool:
            return 8;
        case sectionTypeDirection:
            return 5;
        case sectionTypeSocial:
            return 4;
        case sectionTypeOther:
            return 3;
        default:
            return 0;
    }
}

- (NSString *) titleForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [[[OMUSideMenu sectionRowTitles] objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"menuCell"];
    
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"menuCell"];
        [cell setFrame:CGRectMake(0, 0, SIDE_MENU_WIDTH, 50.0f)];
    }
    
    [cell.textLabel setText:[self titleForRowAtIndexPath:indexPath]];
    
    return cell;
}

- (NSString *) titleForHeaderInSection:(NSInteger)section {
    switch (section) {
        case sectionTypeHome:
            return @"Home";
        case sectionTypeSchool:
            return @"School Organizer";
        case sectionTypeDirection:
            return @"Directions to...";
        case sectionTypeSocial:
            return @"Social Feeds";
        case sectionTypeOther:
            return @"Other Stuff";
        default:
            return 0;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return [OMUSideMenuHeader heightForHeader];
}

-(UIView*)tableView:(UITableView*)tableView viewForHeaderInSection:(NSInteger)section {
    OMUSideMenuHeader *sectionHeaderView = [_menu dequeueReusableHeaderFooterViewWithIdentifier:[OMUSideMenuHeader reuseIdentifier]];
    
    if (!sectionHeaderView) {
        sectionHeaderView = [[OMUSideMenuHeader alloc] init];
        sectionHeaderView.delegate = self;
    }
    
    sectionHeaderView.section = section;
    [sectionHeaderView configureWithTitle:[self titleForHeaderInSection:section] andImageNamed:@""];
    
    return sectionHeaderView;
}

-(void)sectionHeaderView:(OMUSideMenuHeader *)sectionHeaderView sectionOpened:(NSInteger)sectionOpened {
    if (sectionOpened == sectionTypeHome) {
        [self.delegate popAllControllersToRoot];
        return;
    }
    
    NSMutableArray *indexPathsToInsert = [[NSMutableArray alloc] init];
    for (NSInteger i = 0; i < [[[OMUSideMenu sectionRowTitles] objectAtIndex:sectionOpened] count]; i++) {
        [indexPathsToInsert addObject:[NSIndexPath indexPathForRow:i inSection:sectionOpened]];
    }
    
    NSMutableArray *indexPathsToDelete = [[NSMutableArray alloc] init];

    if (_openSectionIndex != NSNotFound) {
        [((OMUSideMenuHeader *)[_menu headerViewForSection:_openSectionIndex]) collapseMenu];
        for (NSInteger i = 0; i < [[[OMUSideMenu sectionRowTitles] objectAtIndex:_openSectionIndex] count]; i++) {
            [indexPathsToDelete addObject:[NSIndexPath indexPathForRow:i inSection:_openSectionIndex]];
        }
    }
    
    // Style the animation so that there's a smooth flow in either direction.
    UITableViewRowAnimation insertAnimation;
    UITableViewRowAnimation deleteAnimation;
    if (_openSectionIndex == NSNotFound || sectionOpened < _openSectionIndex) {
        insertAnimation = UITableViewRowAnimationTop;
        deleteAnimation = UITableViewRowAnimationBottom;
    }
    else {
        insertAnimation = UITableViewRowAnimationBottom;
        deleteAnimation = UITableViewRowAnimationTop;
    }
    
    // Apply the updates.
    _openSectionIndex = sectionOpened;
    
    [_menu beginUpdates];
    [_menu insertRowsAtIndexPaths:indexPathsToInsert withRowAnimation:insertAnimation];
    [_menu deleteRowsAtIndexPaths:indexPathsToDelete withRowAnimation:deleteAnimation];
    [_menu endUpdates];
}


-(void)sectionHeaderView:(OMUSideMenuHeader *)sectionHeaderView sectionClosed:(NSInteger)sectionClosed {
    if (sectionClosed == sectionTypeHome) {
        [self.delegate popAllControllersToRoot];
        return;
    }
    
    NSInteger countOfRowsToDelete = [[[OMUSideMenu sectionRowTitles] objectAtIndex:sectionClosed] count];
    
    _openSectionIndex = NSNotFound;
    
    if (countOfRowsToDelete > 0) {
        NSMutableArray *indexPathsToDelete = [[NSMutableArray alloc] init];
        for (NSInteger i = 0; i < countOfRowsToDelete; i++) {
            [indexPathsToDelete addObject:[NSIndexPath indexPathForRow:i inSection:sectionClosed]];
        }
        
        [_menu deleteRowsAtIndexPaths:indexPathsToDelete withRowAnimation:UITableViewRowAnimationTop];
    }
}

+ (NSArray * const) sectionRowTitles {
    static NSArray *sectionRowTitles = nil;
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        sectionRowTitles = @[@[],
                            @[@"Courses", @"Assignments", @"Midterms", @"Exam Schedule", @"Co-op Planner", @"UW Learn", @"Jobmine", @"Quest"],
                             @[@"Campus Guide", @"Food", @"Study Spots", @"Parking", @"Around the City"],
                             @[@"Reddit UW", @"Twitter", @"Goose Watch", @"Events"],
                             @[@"News", @"Suggestions", @"About the App"]];
    });
    
    return sectionRowTitles;
}

@end
