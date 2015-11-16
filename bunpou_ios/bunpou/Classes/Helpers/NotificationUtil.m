//
//  NotificationUtil.m
//  KanjiBook
//
//  Created by Trần Hải Linh on 2/24/14.
//  Copyright (c) 2014 haimv-pc. All rights reserved.
//

#import "NotificationUtil.h"

@implementation NotificationUtil

+ (void) openNotificationAtBeginDate:(NSInteger) seconds;
{
    // Cancel all notification
    [[UIApplication sharedApplication] cancelAllLocalNotifications];
    // Schedule the notification
    UILocalNotification* localNotification = [[UILocalNotification alloc] init];
    localNotification.fireDate =[NSDate dateWithTimeIntervalSinceNow:seconds];
    localNotification.alertBody = NSLocalizedString(@"NotificationMessage", @"");
    localNotification.repeatInterval = NSDayCalendarUnit;
    localNotification.timeZone = [NSTimeZone defaultTimeZone];
    localNotification.applicationIconBadgeNumber = [[UIApplication sharedApplication] applicationIconBadgeNumber] + 1;
    
    [[UIApplication sharedApplication] scheduleLocalNotification:localNotification];
    
}
+ (void) openNotificationAtDate:(NSInteger) hour
{
    // Cancel all notification
    [[UIApplication sharedApplication] cancelAllLocalNotifications];
    // Schedule the notification
    UILocalNotification* localNotification = [[UILocalNotification alloc] init];
    localNotification.fireDate =[self dateBeginNotificationAtHours:hour];
    localNotification.alertBody = NSLocalizedString(@"NotificationMessage", @"");
    localNotification.repeatInterval = NSDayCalendarUnit;
    localNotification.timeZone = [NSTimeZone defaultTimeZone];
    localNotification.applicationIconBadgeNumber = [[UIApplication sharedApplication] applicationIconBadgeNumber] + 1;
    
    [[UIApplication sharedApplication] scheduleLocalNotification:localNotification];
    
}

+ (void) cancelNotification{
    [[UIApplication sharedApplication] cancelAllLocalNotifications];
};

+ (NSDate*) dateBeginNotificationAtHours:(NSInteger) atHours
{
    NSDate *now = [NSDate date];
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar] ;
    NSDateComponents *components = [calendar components:NSYearCalendarUnit|NSMonthCalendarUnit|NSDayCalendarUnit|NSHourCalendarUnit fromDate:now];
    [components setHour:atHours];
    NSDate *today10am = [calendar dateFromComponents:components];
    
    return today10am;
};




@end
