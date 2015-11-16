//
//  CLSlidingRootViewController.m
//  Coolio
//
//  Created by TrinhLD on 3/13/14.
//  Copyright (c) 2014 Gigaworks. corp. All rights reserved.
//

#import "MTSSlidingRootViewController.h"

@interface MTSSlidingRootViewController ()

@end

@implementation MTSSlidingRootViewController

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
    // Title color
    [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObject:RGB(68, 64, 61) forKey:UITextAttributeTextColor]];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    // Navigation item
//    UIBarButtonItem *btnMenu = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"LeftMenu.png"] style:UIBarButtonItemStyleBordered target:self action:@selector(revealMenu:)];
    UIButton *btnMenu = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 32, 32)];
    [btnMenu setImage:[UIImage imageNamed:@"ic_left_menu"] forState:UIControlStateNormal];
    [btnMenu setImage:[UIImage imageNamed:@"ic_left_menu_ac"] forState:UIControlStateHighlighted];
    [btnMenu addTarget:self action:@selector(revealMenu:) forControlEvents:UIControlEventTouchUpInside];
    [self.navigationItem setLeftBarButtonItem:[[UIBarButtonItem alloc] initWithCustomView:btnMenu]];
//    self.navigationItem.leftBarButtonItem = btnMenu;
    
    if (![self.slidingViewController.underLeftViewController isKindOfClass:[MTSLeftMenuViewController class]]) {
        self.slidingViewController.underLeftViewController = [[MTSLeftMenuViewController alloc] init];
    }
    self.slidingViewController.underRightViewController = nil;
    
    [self.view addGestureRecognizer:self.slidingViewController.panGesture];
    
}

- (void)revealMenu:(id)sender
{
    // Hide keyboard
    [self.view endEditing:YES];
    [self.slidingViewController anchorTopViewTo:ECRight];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
