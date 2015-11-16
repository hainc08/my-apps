//
//  MTSBaseViewController.m
//  KanjiBook
//
//  Created by Vnext's Mac Mini on 2/22/14.
//  Copyright (c) 2014 haimv-pc. All rights reserved.
//

#import "MTSBaseViewController.h"
#import "addID.h"

@interface MTSBaseViewController ()

@end

@implementation MTSBaseViewController

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
    if (SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"7.0")) {
        self.edgesForExtendedLayout = UIRectEdgeNone;
//        [[UINavigationBar appearance] setBackIndicatorImage:[UIImage imageNamed:@"ic_back_ac"]];
//        [[UINavigationBar appearance] setBackIndicatorTransitionMaskImage:[UIImage imageNamed:@"ic_back"]];
        
    }
    
	// Do any additional setup after loading the view.
    [self initAdmobBaner];
}


#pragma mark - Init Admob Banner
-(void)initAdmobBaner{
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    self.bannerView = [[GADBannerView alloc] initWithFrame:CGRectMake(0.0,screenRect.size.height- GAD_SIZE_320x50.height, GAD_SIZE_320x50.width, GAD_SIZE_320x50.height)];
    
    self.bannerView.adUnitID = MyadUnitID;
    self.bannerView.delegate = self;
    [self.bannerView setRootViewController:self];
    [self.view addSubview:self.bannerView];
    [self.bannerView loadRequest:[self createRequest]];
    
    
}
-(GADRequest *) createRequest{
    GADRequest *request = [GADRequest request];
    request.testDevices = [NSArray arrayWithObjects:@"0e460730eff7c4d1513829070e7fc553", nil];
    return request;
}
-(void) adViewDidReceiveAd:(GADBannerView *)adview{
    
    
    [UIView animateWithDuration:1.0 animations:^ {
        CGRect screenRect = [[UIScreen mainScreen] bounds];
        
        adview.frame = CGRectMake(0.0, screenRect.size.height- GAD_SIZE_320x50.height - 64,
                                  adview.frame.size.width, adview.frame.size.height);
    }];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
