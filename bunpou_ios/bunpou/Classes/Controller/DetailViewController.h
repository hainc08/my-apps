//
//  DetailViewController.h
//  bunpou
//
//  Created by haimv-pc on 2014/02/25.
//  Copyright (c) 2014年 haimv-pc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ObjGrammar.h"
#import "MTSBaseViewController.h"

@interface DetailViewController : MTSBaseViewController<GADBannerViewDelegate>{
    ObjGrammar *objGr;
    
    IBOutlet UILabel *lbTitle;
    IBOutlet UITextView *_txtContent;
    
    BOOL result;
}
@property(nonatomic,retain) ObjGrammar *objGr;
@property(nonatomic,retain) IBOutlet UILabel *lbTitle;
@property(nonatomic) UIButton *btFavo;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil withObject:(ObjGrammar *)obj;


@end
