//
//  TopViewController.m
//  bunpou
//
//  Created by haimv-pc on 2014/02/24.
//  Copyright (c) 2014年 haimv-pc. All rights reserved.
//

#import "TopViewController.h"

#import "FMDBDataAccess.h"
#import "DetailViewController.h"
#import "Global.h"
#import "GrammarTableViewCell.h"
#import "addID.h"
#import "Util.h"

#import "MTSLeftMenuViewController.h"

#import "GADInterstitial.h"
#import "GADInterstitialDelegate.h"

@interface TopViewController (){
    int grammarLevel;
}
@end

@implementation TopViewController

@synthesize tblList,aryGrammar,aryGrammarSearch;
@synthesize sbSearch,searchDisplay;
@synthesize isFiltered;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil withLevel:(int)level
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        grammarLevel = level;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    

    if (grammarLevel>0) {
        self.title =[NSString stringWithFormat:@"JLPT N%d",grammarLevel];
    }else{
        self.title =[NSString stringWithFormat:@"JLPT N%d",5];
    }

    
    id desiredColor = [UIColor colorWithRed:233.0/255.0 green:244.0/255.0 blue:244.0/255.0 alpha:1.0f];
    [ self.tblList setBackgroundView:nil];
    [ self.tblList setBackgroundView:[[UIView alloc] init]];
    self.tblList.backgroundView.backgroundColor = desiredColor;
    
    sbSearch = [[UISearchBar alloc]initWithFrame:CGRectMake(0.0f, 0.0f, 320.0f, 44.0f)];
    self.tblList.tableHeaderView = sbSearch;
    // we need to be the delegate so the cancel button works
    sbSearch.delegate = self;
    
    // create the Search Display Controller with the above Search Bar
    self.searchDisplay = [[UISearchDisplayController alloc]initWithSearchBar:self.sbSearch contentsController:self];
    self.searchDisplay.searchResultsDataSource = self;
    self.searchDisplay.searchResultsDelegate = self;
    [self setupMenuBarButtonItems];
    [self initData:grammarLevel];
    
    int64_t delayInSeconds = 10.0f;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        [self initGAD];
    });
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.screenName = [NSString stringWithFormat:@"JLPT N%d",grammarLevel];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    
}


#pragma -mark
#pragma -mark Data
-(void) initData:(int)level{
    
    if (aryGrammar == nil) {
        aryGrammar = [[NSMutableArray alloc] init];
    }else{
        [aryGrammar removeAllObjects];
    }
    //get data from DB
    aryGrammar = [FMDBDataAccess getGrammarListByLevel:level];
    
}
#pragma mark -
#pragma mark Table View Data Source Methods

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (isFiltered) {
        return [aryGrammarSearch count];
    }else {
        return [aryGrammar count];
    }
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44.0f ;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger mrow = indexPath.row;
    
    if (isFiltered) {
        if (mrow < [aryGrammarSearch count]) {
            objGr = [ aryGrammarSearch objectAtIndex:indexPath.row];
        }
    }else {
        if (mrow < [aryGrammar count]) {
            objGr = [ aryGrammar objectAtIndex:indexPath.row];
        }
    }
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView  dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
//        NSArray* views = [[NSBundle mainBundle] loadNibNamed:@"GrammarTableViewCell" owner:nil options:nil];
//        for (UIView *view in views) {
//            if([view isKindOfClass:[UITableViewCell class]])
//            {
//                cell = (GrammarTableViewCell*)view;
//                cell.lbTitle.text = objGr.g_title;
//                if (true == [FMDBDataAccess checkExitsFavorite:objGr.g_id]) {
//                    [cell.icon setImage:[UIImage imageNamed:@"ic_far_line_ac.png"]];
//                }
//            }
//        }
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    cell.textLabel.text = objGr.g_title;
    cell.textLabel.font = [UIFont systemFontOfSize:15];
    cell.imageView.image = [UIImage imageNamed:@"ic_far_line_ac.png"];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    //view detail
    if (isFiltered) {
        if (indexPath.row < [aryGrammarSearch count]) {
            objGr = [ aryGrammarSearch objectAtIndex:indexPath.row];
        }
    }else {
        if (indexPath.row < [aryGrammar count]) {
            objGr = [ aryGrammar objectAtIndex:indexPath.row];
        }
    }
    
    //to view detail title
    DetailViewController*detailView = [[DetailViewController alloc] initWithNibName:@"DetailViewController" bundle:nil withObject:objGr];
    [self.navigationController pushViewController:detailView animated:YES];
}

#pragma mark -
#pragma mark - Search delegate

- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar {
    [sbSearch sizeToFit];
	[sbSearch setShowsCancelButton:YES animated:YES];
	return YES;
}

- (BOOL)searchBarShouldEndEditing:(UISearchBar *)searchBar {
    [sbSearch sizeToFit];
    [sbSearch setShowsCancelButton:NO animated:YES];
	return YES;
}
- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar{
    isFiltered = false;
    [tblList reloadData];
    [searchBar resignFirstResponder];
    [searchBar setShowsCancelButton:NO animated:YES];
}

-(void)searchBar:(UISearchBar*)searchBar textDidChange:(NSString*)text{
    if(text.length == 0)
    {
        isFiltered = FALSE;
    }
    else{
        isFiltered = true;
        aryGrammarSearch = [[NSMutableArray alloc] init];
        for (ObjGrammar *objgr in aryGrammar) {
            NSRange titleRange  = [objgr.g_title rangeOfString:text options:NSCaseInsensitiveSearch];
            NSRange contentRange = [objgr.g_content rangeOfString:text options:NSCaseInsensitiveSearch];
            if(titleRange.location != NSNotFound || contentRange.location != NSNotFound )
            {
                [aryGrammarSearch addObject:objgr] ;
            }
        }
    }
    
    //reload data
    [tblList reloadData];
    
}

#pragma mark -
#pragma mark - UIBarButtonItems

- (void)setupMenuBarButtonItems {
    self.navigationItem.leftBarButtonItem = [self leftMenuBarButtonItem];
}

- (UIBarButtonItem *)leftMenuBarButtonItem {
    return [[UIBarButtonItem alloc]
            initWithImage:[UIImage imageNamed:@"menu-icon.png"] style:UIBarButtonItemStyleBordered
            target:self
            action:@selector(leftSideMenuButtonPressed:)];
}


- (IBAction)leftSideMenuButtonPressed:(UIStoryboardSegue*)sender {
     [self.slidingViewController anchorTopViewTo:ECRight];
}
#pragma mark GADInterstitialDelegate implementation
- (void)interstitialDidReceiveAd:(GADInterstitial *)interstitial {
    [self showGAD];
}

- (void)interstitial:(GADInterstitial *)interstitial
didFailToReceiveAdWithError:(GADRequestError *)error {
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
    self.interstitial.adUnitID = MyadUnitID;
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
//    [self initAdmobBaner];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
