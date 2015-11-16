//
//  NotificationUtil.h
//  KanjiBook
//
//  Created by Trần Hải Linh on 2/24/14.
//  Copyright (c) 2014 haimv-pc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NotificationUtil : NSObject


+ (void) openNotificationAtBeginDate:(NSInteger) second;

+ (void) openNotificationAtDate:(NSInteger) hour;

+ (void) cancelNotification;

+ (NSDate*) dateBeginNotificationAtHours:(NSInteger) atHours;



@end
