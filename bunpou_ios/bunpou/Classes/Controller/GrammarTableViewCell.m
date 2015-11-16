//
//  GrammarTableViewCell.m
//  bunpou
//
//  Created by haimv on 2014/02/26.
//  Copyright (c) 2014年 haimv-pc. All rights reserved.
//

#import "GrammarTableViewCell.h"

@implementation GrammarTableViewCell

@synthesize lbTitle;

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
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
@end
