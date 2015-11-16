//
//  MTSBaseViewController.h
//  KanjiBook
//
//  Created by Vnext's Mac Mini on 2/22/14.
//  Copyright (c) 2014 haimv-pc. All rights reserved.
//

#import "GAITrackedViewController.h"
#import "Global.h"


#import "GADBannerView.h"

@interface MTSBaseViewController : GAITrackedViewController <GADBannerViewDelegate>{
     GADBannerView *bannerView_;
}

@property(nonatomic, strong) GADBannerView *bannerView;
-(GADRequest *)createRequest;


@end
