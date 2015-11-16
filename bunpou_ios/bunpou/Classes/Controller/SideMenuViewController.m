//
//  SideMenuViewController.m
//  MFSideMenuDemo
//
//  Created by Michael Frederick on 3/19/12.

#import "SideMenuViewController.h"
#import "MFSideMenu.h"
#import "TopViewController.h"
#import "Util.h"

@interface SideMenuViewController (){
        NSArray *aryLevel;
}

@property(nonatomic,retain)NSArray *aryLevel;


@end

@implementation SideMenuViewController

@synthesize aryLevel;

#pragma mark -
#pragma mark - UITableViewDataSource

- (void)viewDidLoad
{
    [super viewDidLoad];
    aryLevel = [NSArray arrayWithObjects:@"Level 1",@"Level 2",@"Level 3",@"Level 4",@"Level 5", nil];
    
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return nil;// [NSString stringWithFormat:@"Section %d", section];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [aryLevel count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    cell.textLabel.text = [aryLevel objectAtIndex:indexPath.row];
    
    return cell;
}

#pragma mark -
#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [Util setLevel:indexPath.row+1];
//    TopViewController *topController = [[TopViewController alloc] initWithNibName:@"TopViewController" bundle:nil withLevel:indexPath.row + 1];
    [self.menuContainerViewController setMenuState:MFSideMenuStateClosed];
}

@end
