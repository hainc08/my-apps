//
//  MenuViewCell.m
//  bunpou
//
//  Created by HAIMV on 3/5/26 H.
//  Copyright (c) 26 Heisei haimv-pc. All rights reserved.
//

#import "MenuViewCell.h"
#import "FMDBDataAccess.h"


@implementation MenuViewCell

@synthesize lbNum,lbTitle,imgIcon;


- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code

    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    CGRect accessoryFrame = self.accessoryView.frame;
    accessoryFrame.origin.x -= 30;
    self.accessoryView.frame = accessoryFrame;
}

@end
