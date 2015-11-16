//
//  HistoryViewController.h
//  bunpou
//
//  Created by haimv-pc on 2014/02/24.
//  Copyright (c) 2014年 haimv-pc. All rights reserved.
//

#import "MTSSlidingRootViewController.h"
#import "ObjGrammar.h"


@interface HistoryViewController : MTSSlidingRootViewController<UITableViewDataSource,UITableViewDelegate,GADBannerViewDelegate>{
        NSMutableArray *aryGrammar;
        ObjGrammar *objGr;
  
}

@property (nonatomic,retain) NSMutableArray *aryGrammar;
@property (nonatomic,retain) ObjGrammar *objGr;
@end
