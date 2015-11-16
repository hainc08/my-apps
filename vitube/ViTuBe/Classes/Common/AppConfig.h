//
//  AppConfig.h
//  LeftMenuBar
//
//  Created by haimv on 2015/10/29.
//  Copyright © 2015年 haimv. All rights reserved.
//

#ifndef AppConfig_h
#define AppConfig_h


/**
 *   define
 */

#define ScreenHeight [[UIScreen mainScreen] bounds].size.height
#define ScreenWidth [[UIScreen mainScreen] bounds].size.width
#define iOS7GE [[[UIDevice currentDevice]systemVersion] floatValue] >= 7.0
#define ApplicationDelegate ((AppDelegate *)[UIApplication sharedApplication].delegate)

#define YiBlue [UIColor colorWithRed:0.24f green:0.51f blue:0.78f alpha:1.00f]
#define YiRed [UIColor colorWithRed:0.92 green:0.26 blue:0.21 alpha:1]
#define YiGray [UIColor colorWithRed:0.80f green:0.80f blue:0.80f alpha:1.00f]
#define YiTextGray [UIColor colorWithRed:0.54f green:0.54f blue:0.54f alpha:1.00f]

#define SYSTEM_VERSION_EQUAL_TO(v)                  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedSame)
#define SYSTEM_VERSION_GREATER_THAN(v)              ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedDescending)
#define SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(v)  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN(v)                 ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN_OR_EQUAL_TO(v)     ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedDescending)

#define IS_IPAD (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
#define IS_IPHONE (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
#define IS_IPHONE_5 (IS_IPHONE && [[UIScreen mainScreen] bounds].size.height == 568.0)
#define IS_IPHONE_ABOVE5 (IS_IPHONE && [[UIScreen mainScreen] bounds].size.height >= 568.0)
#define IS_RETINA ([[UIScreen mainScreen] scale] == 2.0)

// block self
#define WEAKSELF typeof(self) __weak weakSelf = self;
#define STRONGSELF typeof(weakSelf) __strong strongSelf = weakSelf;

//ADMOB
#define ADMOB_BANNER @"ca-app-pub-6855516893898980/3173181354"
#define ADMOB_FULL @"ca-app-pub-6855516893898980/4649914554"
#define ADMOB_MY_DEVICE @""

//CONNECTION STRING
#define URLSTRING @""

#endif /* AppConfig_h */
