//
//  MTSLeftMenuViewController.m
//  MinanoNihongo
//
//  Created by Vnext's Mac Mini on 2/24/14.
//  Copyright (c) 2014 MTS. All rights reserved.
//

#import "MTSLeftMenuViewController.h"
#import "TopViewController.h"

#import "HistoryViewController.h"
#import "FavoriteViewController.h"

#import "MenuViewCell.h"

#import "FMDBDataAccess.h"

@interface MTSLeftMenuViewController ()


@end

@implementation MTSLeftMenuViewController
@synthesize aryLevel,listFavourite,listLesson,arySetting;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.slidingViewController setAnchorRightRevealAmount:280.0f];
    self.slidingViewController.underLeftWidthLayout = ECFullWidth;
    
      aryLevel = [NSArray arrayWithObjects:@"JPLT N1",@"JPLT N2",@"JPLT N3",@"JPLT N4",@"JPLT N5", nil];
      arySetting = [NSArray arrayWithObjects:NSLocalizedString(@"history",nil),NSLocalizedString(@"favorite",nil), nil];
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
//    [self.tableView reloadData];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



#pragma mark -- Table view datasource & delegate --
//- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
//    NSString *lbHeader = @"";
//    switch (section) {
//        case 0:
//            lbHeader= NSLocalizedString(@"menu",nil);
//            break;
//        case 1:
//            lbHeader = NSLocalizedString(@"level", nil);
//            break;
//        default:
//            break;
//    }
//  
//    return lbHeader;
//}

//- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
//    
//    NSString *lbHeader = @"";
//    switch (section) {
//        case 0:
//            lbHeader= NSLocalizedString(@"Account",nil);
//            break;
//        case 1:
//            lbHeader = NSLocalizedString(@"level", nil);
//            break;
//        default:
//            break;
//    }
//
//    // Create label with section title
//    UILabel *label = [[UILabel alloc] init];
//    label.frame = CGRectMake(10, 10, 284, 23);
//    label.textColor = [UIColor blackColor];
//    label.font = [UIFont fontWithName:@"Helvetica" size:15];
//    label.text = lbHeader;
//    label.backgroundColor = [UIColor clearColor];
//    
//    // Create header view and add label as a subview
//    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(10, 10, 320, 100)];
//    [view addSubview:label];
//    view.backgroundColor = [UIColor grayColor];
//    return view;
//}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    switch (section) {
        case 0:
            return NSLocalizedString(@"Account",nil);
            break;
        case 1:
            return NSLocalizedString(@"level", nil);
            break;
        default:
            return nil;
            break;
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.5f;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 25;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 42;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)sectionIndex
{
    NSInteger count = 0;
    switch (sectionIndex) {
        case 0:
            count= self.arySetting.count;
            break;
        case 1:
            count= self.aryLevel.count;
            break;
        default:
            break;
    }
    return count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *cellIdentifier = @"MenuItemCell";
    MenuViewCell *cell = [tableView  dequeueReusableCellWithIdentifier:cellIdentifier];

    if (cell == nil){
        NSArray* views = [[NSBundle mainBundle] loadNibNamed:@"MenuViewCell" owner:nil options:nil];
        
        for (UIView *view in views) {
            if([view isKindOfClass:[UITableViewCell class]])
            {
                cell = (MenuViewCell*)view;
                 if (indexPath.section == 0) {
                     //cell.imgIcon.hidden = YES;
                     cell.lbTitle.text = [self.arySetting objectAtIndex:indexPath.row];
                     [cell.lbNum setHidden:YES];
                     
                     if(indexPath.row == 0){
                         [cell.imgIcon setImage:[UIImage imageNamed:@"ic_left_history.png"] ];
                     }
                     if(indexPath.row == 1){
                         [cell.imgIcon setImage:[UIImage imageNamed:@"ic_left_bookmark.png"]];
                     }
                   
                 }else{
                     [cell.imgIcon setImage:[UIImage imageNamed:[NSString stringWithFormat:@"ic_left_n%d.png",indexPath.row+1]]];
                     cell.lbTitle.text = [self.aryLevel objectAtIndex:indexPath.row];
                     cell.lbNum.text = [NSString stringWithFormat:@"%lu",(unsigned long)[FMDBDataAccess countByLevel:indexPath.row+1]];
                 }

            }
        }
//        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }

    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.tableView reloadData];
    MenuViewCell *cell = (MenuViewCell*)[tableView cellForRowAtIndexPath:indexPath];
    cell.contentView.backgroundColor = [UIColor whiteColor];
    
    if (indexPath.section== 0) {
        if (indexPath.row == 0) {
            [cell.imgIcon setImage:[UIImage imageNamed:@"ic_left_history_ac.png"]];
            
            HistoryViewController *historyViewController = [[HistoryViewController alloc] initWithNibName:@"HistoryViewController" bundle:nil];
            UINavigationController *navController = [[UINavigationController alloc]initWithRootViewController:historyViewController];
            
            [self.slidingViewController anchorTopViewOffScreenTo:ECRight animations:nil onComplete:^{
                CGRect frame = self.slidingViewController.topViewController.view.frame;
                self.slidingViewController.topViewController = navController;
                self.slidingViewController.topViewController.view.frame = frame;
                [self.slidingViewController resetTopView];
            }];

            
        }
        if (indexPath.row == 1) {
            [cell.imgIcon setImage:[UIImage imageNamed:@"ic_left_bookmark_ac.png"]];
            
            FavoriteViewController *favoriteViewController = [[FavoriteViewController alloc] initWithNibName:@"FavoriteViewController" bundle:nil];
            UINavigationController *navController = [[UINavigationController alloc]initWithRootViewController:favoriteViewController];
            [self.slidingViewController anchorTopViewOffScreenTo:ECRight animations:nil onComplete:^{
                CGRect frame = self.slidingViewController.topViewController.view.frame;
                self.slidingViewController.topViewController = navController;
                self.slidingViewController.topViewController.view.frame = frame;
                [self.slidingViewController resetTopView];
            }];
        }
    }else{
        [cell.imgIcon setImage:[UIImage imageNamed:[NSString stringWithFormat:@"ic_left_n%d_ac.png",indexPath.row+1]]];

        TopViewController *topViewController = [[TopViewController alloc] initWithNibName:@"TopViewController" bundle:nil withLevel:indexPath.row +1];
        UINavigationController *navController = [[UINavigationController alloc]initWithRootViewController:topViewController];
        
        [self.slidingViewController anchorTopViewOffScreenTo:ECRight animations:nil onComplete:^{
            CGRect frame = self.slidingViewController.topViewController.view.frame;
            self.slidingViewController.topViewController = navController;
            self.slidingViewController.topViewController.view.frame = frame;
            [self.slidingViewController resetTopView];
        }];
        

        
    }
}



@end
