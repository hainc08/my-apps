//
//  Date.h
//  KanjiBook
//
//  Created by Trần Hải Linh on 2/13/14.
//  Copyright (c) 2014 haimv-pc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Date : NSObject

//#define  DATE_FORMAT_YYYY_MM_DD @"yyyy-MM-dd";

extern NSString* const DATE_FORMAT_YYYY_MM_DD;

//+ (NSDate*) currentdate;

+ (NSInteger) dayOfDate:(NSDate*) date;

+ (NSInteger) monthOfDate:(NSDate*) date;

+ (NSInteger) yearOfDate:(NSDate*) date;

+ (NSString*) dayNameOfWeek:(NSDate*) date;

+ (NSString*) monthNameOfYear:(NSDate*) date;

+ (NSInteger) hourOfDate:(NSDate*) date;

+ (NSInteger) secondsOfDate:(NSDate*) date;

+ (NSInteger) secondsFrom:(NSDate*)fromDate toDate:(NSDate*) toDate;

@end
