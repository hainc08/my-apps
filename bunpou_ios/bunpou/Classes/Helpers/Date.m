//
//  Date.m
//  KanjiBook
//
//  Created by Trần Hải Linh on 2/13/14.
//  Copyright (c) 2014 haimv-pc. All rights reserved.
//

#import "Date.h"

@implementation Date
NSString* const DATE_FORMAT_YYYY_MM_DD = @"yyyy-MM-dd";


+ (NSInteger) dayOfDate:(NSDate*) date{
    NSCalendar* calender = [NSCalendar currentCalendar];
    NSDateComponents* component = [calender components:NSDayCalendarUnit fromDate:date];
    
    return [component day];
};

+ (NSInteger) monthOfDate:(NSDate*) date{
    
    NSCalendar* calender = [NSCalendar currentCalendar];
    NSDateComponents* component = [calender components:NSMonthCalendarUnit fromDate:date];
    
    return [component month];
}

+ (NSInteger) yearOfDate:(NSDate *)date{
    
    NSCalendar* calender = [NSCalendar currentCalendar];
    NSDateComponents* component = [calender components:NSYearCalendarUnit fromDate:date];
    
    return [component year];
}

+ (NSString*) dayNameOfWeek:(NSDate *)date{
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"EEE"];
    return [dateFormat stringFromDate:date];
}

+ (NSString*) monthNameOfYear:(NSDate *)date{
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"MMM"];
    return [dateFormat stringFromDate:date];
}
+ (NSInteger) hourOfDate:(NSDate*) date{
    //
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar] ;
    NSDateComponents *components = [calendar components:NSHourCalendarUnit fromDate:date];
    
    return  [components hour];
    
};
+ (NSInteger) secondsOfDate:(NSDate*) date{
    //
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar] ;
     NSDateComponents *components = [calendar components:NSSecondCalendarUnit fromDate:date];
    
    return  [components second];
}


+ (NSInteger) secondsFrom:(NSDate*)fromDate toDate:(NSDate*) toDate{
    
    // from date
    NSInteger secondsFromDate = [self secondsOfDate:fromDate];
    NSInteger dayFromDate = [self dayOfDate:fromDate];

    // to date
    NSInteger secondsToDate = [self secondsOfDate:toDate];
    NSInteger dayToDate = [self dayOfDate:toDate];
    
    return  (dayToDate - dayFromDate)* 24 * 60 * 60 + secondsToDate - secondsFromDate;
};


@end
