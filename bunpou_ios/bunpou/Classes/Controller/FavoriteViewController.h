//
//  FavoriteViewController.h
//  bunpou
//
//  Created by HAIMV on 2/28/26 H.
//  Copyright (c) 26 Heisei haimv-pc. All rights reserved.
//

#import "MTSSlidingRootViewController.h"
#import "ObjGrammar.h"

@interface FavoriteViewController : MTSSlidingRootViewController<UITableViewDataSource,UITableViewDataSource,GADBannerViewDelegate>
{
//     GADBannerView *bannerView_;
    
    NSMutableArray *aryGrammar;
    ObjGrammar *objGr;

    
}

@end
