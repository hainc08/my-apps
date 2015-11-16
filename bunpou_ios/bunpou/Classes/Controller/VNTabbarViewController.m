//
//  VNTabbarViewController.m
//  BuzzLocation
//
//  Created by TrinhLD on 12/19/13.
//  Copyright (c) 2013 vnext. All rights reserved.
//

#import "VNTabbarViewController.h"
#import "TopViewController.h"
#import "SearchViewController.h"
#import "HistoryViewController.h"
#import "InfoViewController.h"

@interface VNTabbarViewController ()

@end

@implementation VNTabbarViewController

- (id)init
{
    self = [super init];
    if (self) {
        // Set title tabbar color
        [[UITabBarItem appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:COLOR_DEFAULT, UITextAttributeTextColor, nil] forState:UIControlStateSelected];
        // Views
        TopViewController *topViewController = [[TopViewController alloc] initWithNibName:@"TopViewController" bundle:nil];
        UINavigationController *topViewNav = [[UINavigationController alloc] initWithRootViewController:topViewController];
        [topViewNav.tabBarItem setFinishedSelectedImage:[UIImage imageNamed:@"list.png"] withFinishedUnselectedImage:[UIImage imageNamed:@"list.png"]];
        //topViewNav.tabBarItem.title = @"List";
        
        //        searchViewNav.tabBarItem.title =@"search";
        
        HistoryViewController *historyViewController = [[HistoryViewController alloc] initWithNibName:@"HistoryViewController" bundle:nil];
        UINavigationController *historyViewNav = [[UINavigationController alloc] initWithRootViewController:historyViewController];
        [historyViewNav.tabBarItem setFinishedSelectedImage:[UIImage imageNamed:@"history.png"] withFinishedUnselectedImage:[UIImage imageNamed:@"history.png"]];
        
        SearchViewController *searchViewController = [[SearchViewController alloc]initWithNibName:@"SearchViewController" bundle:nil];
        UINavigationController *searchViewNav = [[UINavigationController alloc] initWithRootViewController:searchViewController];
        [searchViewNav.tabBarItem setFinishedSelectedImage:[UIImage imageNamed:@"search.png"] withFinishedUnselectedImage:[UIImage imageNamed:@"search.png"]];


        
        InfoViewController *infoViewController = [[InfoViewController alloc] initWithNibName:@"InfoViewController" bundle:nil];
        UINavigationController *infoViewNav = [[UINavigationController alloc] initWithRootViewController:infoViewController];
        [infoViewNav.tabBarItem setFinishedSelectedImage:[UIImage imageNamed:@"info.png"] withFinishedUnselectedImage:[UIImage imageNamed:@"info.png"]];

        
        //add tab view controller
        self.viewControllers = @[topViewNav,searchViewNav,historyViewNav,infoViewNav];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
