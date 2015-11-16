//
//  DetailViewController.m
//  bunpou
//
//  Created by haimv-pc on 2014/02/25.
//  Copyright (c) 2014年 haimv-pc. All rights reserved.
//

#import "DetailViewController.h"
#import "GADRequest.h"
#import "addID.h"
#import "FMDBDataAccess.h"

@interface DetailViewController ()

@end

@implementation DetailViewController
//@synthesize bannerView=bannerView_;
@synthesize objGr,lbTitle,btFavo;

-(void)initData{
    
    self.title = objGr.g_title;
    
    [_txtContent setFont:[UIFont fontWithName:@"Helvetica" size:14]];
    [_txtContent setTextColor:[UIColor blackColor]];
    [_txtContent setBackgroundColor:[UIColor clearColor]];
    _txtContent.editable = NO;
    
    lbTitle.text = objGr.g_title;
    _txtContent.text = objGr.g_content;
    
    //check exits favorite or no
     result = [FMDBDataAccess checkExitsReCor:objGr.g_id];

}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil withObject:(ObjGrammar *)obj
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        objGr = obj;
    }
    return self;
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:YES];
    self.screenName = @"DetailViewController";
    [self initView];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    if (SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"7.0")) {
        [self setEdgesForExtendedLayout:UIRectEdgeNone];
    }
    [self initView];
    
    
    // Do any additional setup after loading the view from its nib.
    [self initData];
    [self addtoHistory];
//    [self initAdmobBaner];
}

-(void)initView{
    btFavo = [UIButton buttonWithType:UIButtonTypeCustom];
    btFavo.showsTouchWhenHighlighted = YES;
    btFavo.frame = CGRectMake(0.0, 0.0, 32, 32);
    [btFavo setImage:[UIImage imageNamed:@"ic_far_tab.png"] forState:UIControlStateNormal];
    [btFavo setImage:[UIImage imageNamed:@"ic_far_tab_ac.png"] forState:UIControlStateSelected];
    [btFavo setSelected:result];

//    if (result == true) {
//        
//        [btFavo setImage:[UIImage imageNamed:@"ic_far_tab_ac.png"] forState:UIControlStateNormal];
//    }else{
//        [btFavo setImage:[UIImage imageNamed:@"ic_far_tab.png"] forState:UIControlStateNormal];
//    }
    [btFavo addTarget:self action:@selector(addFavorite:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *favoriteButton = [[UIBarButtonItem alloc]initWithCustomView:btFavo];
    self.navigationItem.rightBarButtonItem = favoriteButton;//[[UIBarButtonItem alloc] initWithCustomView:favoriteButton];
    

}

-(IBAction)addFavorite:(id)sender{
    if (result == false) {
        [FMDBDataAccess insertToFavorite:objGr];
//        [btFavo setImage:[UIImage imageNamed:@"ic_left_bookmark_ac.png"] forState:UIControlStateNormal];
        result = true;
    }else{
        [FMDBDataAccess deleteFavoriteRecord:objGr];
//        [btFavo setImage:[UIImage imageNamed:@"ic_left_bookmark.png"] forState:UIControlStateNormal];
        result = false;
    }
    [btFavo setSelected:result];
}
-(void)addtoHistory{
    BOOL resultHistory = [FMDBDataAccess checkExitsReCor:objGr.g_id];
    if (resultHistory == false) {
        [FMDBDataAccess insertToHistory:objGr];
    }
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
