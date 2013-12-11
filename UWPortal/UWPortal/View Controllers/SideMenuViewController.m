//
//  SideMenuViewController.m
//  UWPortal
//
//  Created by Eric Lui on 12/10/2013.
//  Copyright (c) 2013 Eric Lui. All rights reserved.
//

#import "SideMenuViewController.h"
#import "UIUtils.h"

@interface SideMenuViewController ()

@end

@implementation SideMenuViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        _openSection = numberOfCellType;
        [self.view setBackgroundColor:[UIColor mainBackgroundColor]];
        [self setTitle:@"Home"];
        
        UIPanGestureRecognizer * panDetection = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panHandler:)];
        [self.view addGestureRecognizer:panDetection];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    _sideMenuView = [[SideMenuView alloc] initWithMenuDelegate:self];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [[[UIApplication sharedApplication] keyWindow] addSubview:_sideMenuView];
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    [_sideMenuView removeFromSuperview];
}

- (void) panHandler:(UIPanGestureRecognizer *) recognizer {
    [_sideMenuView panHandler:recognizer];
}

#pragma mark - Tableview Delegate and Datasource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return numberOfCellType;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [[[SideMenuView sectionRowTitles] objectAtIndex:section] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"bob"];
    
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"bob"];
        [cell setBackgroundColor:[UIColor clearColor]];
        [cell setBackgroundView:[[UIView alloc] initWithFrame:cell.frame]];
        [cell.backgroundView setBackgroundColor:[UIColor sideMenuColor]];
        [cell.backgroundView setAlpha:0.1];
    }

    [cell.textLabel setText:[[[SideMenuView sectionRowTitles]
                                objectAtIndex:indexPath.section]
                                objectAtIndex:indexPath.row]];
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return [SideMenuHeaderView headerHeight];
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    SideMenuHeaderView * header = [tableView dequeueReusableCellWithIdentifier:[SideMenuHeaderView reuseIdentifier]];
    
    if (!header) {
        header = [[SideMenuHeaderView alloc] initWithSectionNumber:section];
    }
    
    [header.textLabel setText:[[SideMenuView sectionHeaderTitles] objectAtIndex:section]];
    
    return header;
}

#pragma mark - Side Menu Header Delegate Methods
//
//-(void)sectionHeaderView:(SideMenuHeaderView *)sectionHeaderView sectionOpened:(NSInteger)sectionOpened {
//    if (sectionOpened == sectionTypeHome) {
//        _openSection = sectionTypeHome;
//        return;
//    }
//    
//    NSMutableArray *indexPathsToInsert = [[NSMutableArray alloc] init];
//    for (NSInteger i = 0; i < [[[SideMenuView sectionRowTitles] objectAtIndex:sectionOpened] count]; i++) {
//        [indexPathsToInsert addObject:[NSIndexPath indexPathForRow:i inSection:sectionOpened]];
//    }
//    
//    NSMutableArray *indexPathsToDelete = [[NSMutableArray alloc] init];
//    
//    if (_openSection != numberOfCellType) {
//        [((SideMenuHeaderView *)[_sideMenuView.menu headerViewForSection:_openSection]) toggleOpenState];
//        for (NSInteger i = 0; i < [[[SideMenuView sectionRowTitles] objectAtIndex:_openSection] count]; i++) {
//            [indexPathsToDelete addObject:[NSIndexPath indexPathForRow:i inSection:_openSection]];
//        }
//    }
//    
//    // Style the animation so that there's a smooth flow in either direction.
//    UITableViewRowAnimation insertAnimation;
//    UITableViewRowAnimation deleteAnimation;
//    if (_openSection == numberOfCellType || sectionOpened < _openSection || _openSection == sectionTypeHome) {
//        insertAnimation = UITableViewRowAnimationTop;
//        deleteAnimation = UITableViewRowAnimationBottom;
//    }
//    else {
//        insertAnimation = UITableViewRowAnimationBottom;
//        deleteAnimation = UITableViewRowAnimationTop;
//    }
//    
//    // Apply the updates.
//    _openSection = (SectionType)sectionOpened;
//    
//    [_sideMenuView.menu beginUpdates];
//    [_sideMenuView.menu insertRowsAtIndexPaths:indexPathsToInsert withRowAnimation:insertAnimation];
//    [_sideMenuView.menu deleteRowsAtIndexPaths:indexPathsToDelete withRowAnimation:deleteAnimation];
//    [_sideMenuView.menu endUpdates];
//}
//
//
//-(void)sectionHeaderView:(SideMenuHeaderView *)sectionHeaderView sectionClosed:(NSInteger)sectionClosed {
//    if (sectionClosed == sectionTypeHome) {
//        return;
//    }
//    
//    NSInteger countOfRowsToDelete = [[[SideMenuView sectionRowTitles] objectAtIndex:sectionClosed] count];
//    
//    _openSection = numberOfCellType;
//    
//    if (countOfRowsToDelete > 0) {
//        NSMutableArray *indexPathsToDelete = [[NSMutableArray alloc] init];
//        for (NSInteger i = 0; i < countOfRowsToDelete; i++) {
//            [indexPathsToDelete addObject:[NSIndexPath indexPathForRow:i inSection:sectionClosed]];
//        }
//        
//        [_sideMenuView.menu deleteRowsAtIndexPaths:indexPathsToDelete withRowAnimation:UITableViewRowAnimationTop];
//    }
//}

@end
