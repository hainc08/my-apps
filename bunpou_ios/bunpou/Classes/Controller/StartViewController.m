//
//  StartViewController.m
//  bunpou
//
//  Created by haimv-pc on 2014/02/24.
//  Copyright (c) 2014年 haimv-pc. All rights reserved.
//

#import "StartViewController.h"

#import "GADInterstitial.h"
#import "GADInterstitialDelegate.h"

#import "MTSInitialSlidingViewController.h"

@interface StartViewController ()<GADInterstitialDelegate>

@end

@implementation StartViewController

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
    // Do any additional setup after loading the view from its nib.
    [self initGAD];
//    [self showGAD];
}


#pragma mark GADInterstitialDelegate implementation

- (void)interstitialDidReceiveAd:(GADInterstitial *)interstitial {
    [self.loadingSpinner stopAnimating];
    [self showGAD];
}

- (void)interstitial:(GADInterstitial *)interstitial
didFailToReceiveAdWithError:(GADRequestError *)error {
    [self.loadingSpinner stopAnimating];
   //change view to top view
}

#pragma mark GADRequest implementation

- (GADRequest *)request {
    GADRequest *request = [GADRequest request];
    
    // Make the request for a test ad. Put in an identifier for the simulator as well as any devices
    // you want to receive test ads.
    request.testDevices = @[
                            // TODO: Add your device/simulator test identifiers here. Your device identifier is printed to
                            // the console when the app is launched.
                            GAD_SIMULATOR_ID
                            ];
    return request;
}

#pragma mark Insterstitial button actions

-(void)initGAD{
    // Create a new GADInterstitial each time.  A GADInterstitial will only show one request in its
    // lifetime. The property will release the old one and set the new one.
    self.interstitial = [[GADInterstitial alloc] init];
    self.interstitial.delegate = self;
    
    // Note: Edit SampleConstants.h to update kSampleAdUnitId with your interstitial ad unit id.
    self.interstitial.adUnitID = @"a1530c56a6c889b";
    [self.loadingSpinner startAnimating];
    [self.interstitial loadRequest:[self request]];
}


-(void)showGAD{
    // Show the interstitial.
    [self.interstitial presentFromRootViewController:self];

}

-(void)interstitialWillPresentScreen:(GADInterstitial *)ad{
    NSLog(@"on screen");
    
}
- (void)interstitialDidDismissScreen:(GADInterstitial *)interstitial{
    NSLog(@"hide GAD");
    MTSInitialSlidingViewController *slidingViewController = [[MTSInitialSlidingViewController alloc] init];
    
    [self.navigationController pushViewController:slidingViewController animated:YES];
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
