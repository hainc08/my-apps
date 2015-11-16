//
//  BaseViewController.m
//  ViTuBe
//
//  Created by haimv on 2015/11/05.
//  Copyright © 2015年 haimv. All rights reserved.
//

#import "BaseViewController.h"

@interface BaseViewController (){
     MBProgressHUD *HUD;
}

@end

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (void) showLoading
{
    HUD = [[MBProgressHUD alloc] initWithView:self.navigationController.view];
    [self.navigationController.view addSubview:HUD];
    HUD.color = [UIColor blackColor];
    HUD.activityIndicatorColor = [UIColor grayColor];
    [HUD show:YES];
};

- (void) hideLoading
{
    [HUD hide:YES];
};


@end
