//
//  StartViewController.h
//  bunpou
//
//  Created by haimv-pc on 2014/02/24.
//  Copyright (c) 2014年 haimv-pc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GADInterstitialDelegate.h"
@class GADInterstitial;
@class GADRequest;

@interface StartViewController : UIViewController<GADInterstitialDelegate>

@property(nonatomic, strong) GADInterstitial *interstitial;
@property(nonatomic, retain) IBOutlet UIActivityIndicatorView *loadingSpinner;
- (GADRequest *)request;

@end
