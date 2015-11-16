//
//  ObjGrammar.h
//  bunpou
//
//  Created by haimv-pc on 2014/02/25.
//  Copyright (c) 2014年 haimv-pc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface ObjGrammar : NSObject{
 int g_id;
    NSString *g_title;
    NSString *g_content;
}

@property(nonatomic)int g_id;
@property(nonatomic,retain) NSString *g_title;
@property(nonatomic,retain) NSString *g_content;



@end
