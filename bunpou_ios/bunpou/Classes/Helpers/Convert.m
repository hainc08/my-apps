//
//  Convert.m
//  KanjiBook
//
//  Created by Trần Hải Linh on 2/13/14.
//  Copyright (c) 2014 haimv-pc. All rights reserved.
//

#import "Convert.h"

@implementation Convert
+ (NSString *) dateToString: (NSDate *) date withFormatDate:(NSString *) format{
    
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:format];
    NSDate *now = [NSDate date];
    NSString *retDate = [dateFormat stringFromDate:now];
    
    return retDate;
}
+ (NSDate *) stringToDate: (NSString *) dateString withFormatDate:(NSString *) format{
    
    // Convert string to date object
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:format];
//    NSDate *retDate = [dateFormat dateFromString:dateString];
    return [dateFormat dateFromString:dateString];
}
@end
