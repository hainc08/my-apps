//
//  Convert.h
//  KanjiBook
//
//  Created by Trần Hải Linh on 2/13/14.
//  Copyright (c) 2014 haimv-pc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Convert : NSObject

+ (NSString *) dateToString:(NSDate *) date withFormatDate:(NSString *) format;

+ (NSDate *) stringToDate:(NSString *) dateString withFormatDate:(NSString *) format;


@end
