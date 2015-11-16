//
//  TopViewController.h
//  bunpou
//
//  Created by haimv-pc on 2014/02/24.
//  Copyright (c) 2014年 haimv-pc. All rights reserved.
//

#import "MTSSlidingRootViewController.h"
#import "ObjGrammar.h"

#import "GADInterstitialDelegate.h"

@interface TopViewController : MTSSlidingRootViewController<UITableViewDelegate,UITableViewDataSource,UISearchBarDelegate,GADInterstitialDelegate>{
    IBOutlet UITableView *tblList;

    
    NSMutableArray *aryGrammar;
    NSMutableArray *aryGrammarSearch;
    ObjGrammar *objGr;
    Boolean isFiltered;
}


#pragma mark - Google analytic
@property(nonatomic,strong) id tracker;


@property (strong, nonatomic) IBOutlet UISearchBar *sbSearch;
@property (nonatomic, retain) IBOutlet UISearchDisplayController *searchDisplay;

@property (nonatomic, retain)  IBOutlet UITableView *tblList;
@property (nonatomic, assign) Boolean isFiltered;
@property (nonatomic,retain) NSMutableArray *aryGrammar;
@property (nonatomic, retain) NSMutableArray *aryGrammarSearch;

@property(nonatomic, strong) GADInterstitial *interstitial;

- (GADRequest *)request;

-(void)searchBar:(UISearchBar*)searchBar textDidChange:(NSString*)text;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil withLevel:(int)level;

@end
