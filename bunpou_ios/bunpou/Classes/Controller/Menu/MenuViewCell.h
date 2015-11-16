//
//  MenuViewCell.h
//  bunpou
//
//  Created by HAIMV on 3/5/26 H.
//  Copyright (c) 26 Heisei haimv-pc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MenuViewCell : UITableViewCell{
    IBOutlet UIImageView *imgIcon;
    IBOutlet UILabel *lbTitle;
    IBOutlet UILabel *lbNum;
    
}

@property(nonatomic) IBOutlet UIImageView *imgIcon;
@property(nonatomic) IBOutlet UILabel *lbTitle;
@property(nonatomic) IBOutlet UILabel *lbNum;


@end
