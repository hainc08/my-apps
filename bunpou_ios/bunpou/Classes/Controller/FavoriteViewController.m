//
//  FavoriteViewController.m
//  bunpou
//
//  Created by HAIMV on 2/28/26 H.
//  Copyright (c) 26 Heisei haimv-pc. All rights reserved.
//

#import "FavoriteViewController.h"
#import "MTSLeftMenuViewController.h"
#import "FMDBDataAccess.h"
#import "GrammarTableViewCell.h"
#import "DetailViewController.h"

@interface FavoriteViewController ()

@end

@implementation FavoriteViewController

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
    
    if (SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"7.0")) {
        [self setEdgesForExtendedLayout:UIRectEdgeNone];
    }
    

    self.title = [NSString stringWithString:NSLocalizedString(@"favorite", Nil)];
    [self initData];
    [self setupMenuBarButtonItems];


}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.screenName = @"Favourite View Controller";
//    [self initLeftMenu];
    [self initData];
}


#pragma -mark
#pragma -mark Data
-(void) initData{
    
    if (aryGrammar == nil) {
        aryGrammar = [[NSMutableArray alloc] init];
    }else{
        [aryGrammar removeAllObjects];
    }
    //get data from DB
    aryGrammar = [FMDBDataAccess getFavoriteList];
    NSLog(@"--count%d",[aryGrammar count]);
    
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
    return 55.0f ;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    objGr = [aryGrammar objectAtIndex:indexPath.row];
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView  dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil){
        
//        NSArray* views = [[NSBundle mainBundle] loadNibNamed:@"GrammarTableViewCell" owner:nil options:nil];
//        
//        for (UIView *view in views) {
//            if([view isKindOfClass:[UITableViewCell class]])
//            {
//                cell = (GrammarTableViewCell*)view;
//                cell.lbTitle.text = objGr.g_title;
//                [cell.icon setImage:[UIImage imageNamed:@"ic_far_line_ac.png"]];
//            }
//        }
        
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    cell.imageView.image = [UIImage imageNamed:@"ic_far_line.png"];
    cell.textLabel.text = objGr.g_title;
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

- (IBAction)leftSideMenuButtonPressed:(UIStoryboardSegue*)sender {
    [self.slidingViewController anchorTopViewTo:ECRight];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
