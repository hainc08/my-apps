//
//  MTSLeftMenuViewController.h
//  MinanoNihongo
//
//  Created by Vnext's Mac Mini on 2/24/14.
//  Copyright (c) 2014 MTS. All rights reserved.
//


#import "ECSlidingViewController.h"

@interface MTSLeftMenuViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>{
    NSInteger numLv1;
    NSInteger numLv2;
    NSInteger numLv3;
    NSInteger numLv4;
    NSInteger numLv5;
}

@property (unsafe_unretained, nonatomic) IBOutlet UITableView *tableView;
@property (retain, nonatomic) NSArray *aryLevel;
@property (retain, nonatomic) NSArray *arySetting;
@property (retain, nonatomic) NSMutableArray *listLesson;
@property (retain, nonatomic) NSMutableArray *listFavourite;



@end
