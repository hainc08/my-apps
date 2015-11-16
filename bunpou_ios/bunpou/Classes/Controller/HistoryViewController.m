//
//  HistoryViewController.m
//  bunpou
//
//  Created by haimv-pc on 2014/02/24.
//  Copyright (c) 2014年 haimv-pc. All rights reserved.
//

#import "HistoryViewController.h"
#import "GrammarTableViewCell.h"
#import "DetailViewController.h"
#import "FMDBDataAccess.h"

#import "MTSLeftMenuViewController.h"


@interface HistoryViewController ()

@end

@implementation HistoryViewController

@synthesize aryGrammar,objGr;
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
    
    
    self.title = [NSString stringWithString:NSLocalizedString(@"history", Nil)];
    // nsstring NSLocalizedString("history", Nil);
    [self initData];
    [self setupMenuBarButtonItems];
//    [self initAdmobBaner];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.screenName = @"History";
}

-(void) initData{
    
    if (aryGrammar == nil) {
        aryGrammar = [[NSMutableArray alloc] init];
    }else{
        [aryGrammar removeAllObjects];
    }
    //get data from DB
    aryGrammar = [FMDBDataAccess getHistoryList];
}

#pragma mark -
#pragma mark Table View Data Source Methods

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

        return [aryGrammar count];

    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44.0f ;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    objGr = [ aryGrammar objectAtIndex:indexPath.row];
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView  dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
//        NSArray* views = [[NSBundle mainBundle] loadNibNamed:@"GrammarTableViewCell" owner:nil options:nil];
//        
//        for (UIView *view in views) {
//            if([view isKindOfClass:[UITableViewCell class]])
//            {
//                cell = (GrammarTableViewCell*)view;
//                cell.lbTitle.text = objGr.g_title;
//                cell.icon.hidden = YES;
//            }
//        }
    }
    cell.textLabel.text = objGr.g_title;
    cell.textLabel.font = [UIFont systemFontOfSize:15];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row < [aryGrammar count]) {
        objGr = [ aryGrammar objectAtIndex:indexPath.row];
    }
    
    //to view detail title
    DetailViewController*detailView = [[DetailViewController alloc] initWithNibName:@"DetailViewController" bundle:nil withObject:objGr];
    detailView.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:detailView animated:YES];
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


- (void)leftSideMenuButtonPressed:(id)sender {
    [self.slidingViewController anchorTopViewTo:ECRight];
}


//#pragma mark - Init Admob Banner
//-(void)initAdmobBaner{
//    CGRect screenRect = [[UIScreen mainScreen] bounds];
//    self.bannerView = [[GADBannerView alloc] initWithFrame:CGRectMake(0.0,screenRect.size.height- GAD_SIZE_320x50.height -100, GAD_SIZE_320x50.width, GAD_SIZE_320x50.height)];
//    
//    self.bannerView.adUnitID = MyadUnitID;
//    self.bannerView.delegate = self;
//    [self.bannerView setRootViewController:self];
//    [self.view addSubview:self.bannerView];
//    [self.bannerView loadRequest:[self createRequest]];
//    
//    
//}
//-(GADRequest *) createRequest{
//    GADRequest *request = [GADRequest request];
//    return request;
//}
//-(void) adViewDidReceiveAd:(GADBannerView *)adview{
//    [UIView animateWithDuration:1.0 animations:^ {
//        CGRect screenRect = [[UIScreen mainScreen] bounds];
//        
//        adview.frame = CGRectMake(0.0, screenRect.size.height- GAD_SIZE_320x50.height - 64,
//                                  adview.frame.size.width, adview.frame.size.height);
//    }];
//    
//}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
