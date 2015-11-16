//
//  TopViewController.m
//  ViTuBe
//
//  Created by haimv on 2015/11/05.
//  Copyright © 2015年 haimv. All rights reserved.
//

#import "TopViewController.h"

#import "VideoCategoriesSource.h"

#import "CategoriesEntity.h"

@interface TopViewController ()

@property (nonatomic, strong) NSMutableArray* aryCategories;

@end

@implementation TopViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self requestCategoriesList];
    
//    NSLog(@"count categories %ld",[self.aryCategories count]);
}


-(void)requestCategoriesList{
    [self showLoading];
    
    CategoryListCompletionBlock completionBlock = ^(NSArray* data,NSString* errorString){
        if (data != nil){
            [self processData:data];
        }
    };
    VideoCategoriesSource* categoriesSource = [VideoCategoriesSource categoriesSource];
    [categoriesSource getCategoriesList:@"1" completion:completionBlock];
}
-(void)processData:(NSArray*)data{
        NSLog(@"eee");
    if ([data count] == 0){
        
    }else{
      [self hideLoading];
        if (!self.aryCategories){
            self.aryCategories = [[NSMutableArray alloc] init];
            self.aryCategories = [NSMutableArray arrayWithArray:data];
        }
    }
    // create grid
    [self createListCategories];
}
-(void)createListCategories{
    NSLog(@"--%ld",[self.aryCategories count]);
    CategoriesEntity *cat = [ self.aryCategories objectAtIndex:1];
    NSLog(@"--channel chanelId %@",cat.chanelId);
    NSLog(@"--channel title %@",cat.chanelTitle);
    
}
@end
