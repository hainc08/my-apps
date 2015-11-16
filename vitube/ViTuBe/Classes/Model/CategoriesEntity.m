//
//  CategoriesEntity.m
//  ViTuBe
//
//  Created by haimv on 2015/11/05.
//  Copyright © 2015年 haimv. All rights reserved.
//

#import "CategoriesEntity.h"
#import "KM_NSDictionary+SafeValues.h"

#define kCategoryId @"id"
#define kchanelId @"channelId"
#define kchanelTitle @"title"

@implementation CategoriesEntity


#pragma mark -
#pragma mark Init Methods

- (void)initialiseWithSafeValues
{
    _categoryId = @"";
    _chanelId = @"";
    _chanelTitle =@"";
    
}

- (id)init{
    self = [super init];
    if (self){
        [self initialiseWithSafeValues];
    }
    return self;
}

- (id)initWithDictionary:(NSDictionary*)dictionary {
    self = [super init];
    if (self){
        [self initialiseWithSafeValues];
         [self processDictionary:dictionary];
    }
    return self;
}
#pragma mark -
#pragma mark Dictionary Parsing

- (void)processDictionary:(NSDictionary*)dictionary {
    if (dictionary)
    {
        _categoryId = [NSString stringWithFormat:@"%d", [[dictionary km_safeNumberForKey:kCategoryId] intValue]];
        NSDictionary* snippetDictionary = [dictionary objectForKey:@"snippet"];
        _chanelId = [NSString stringWithFormat:@"%@",[snippetDictionary km_safeStringForKey:kchanelId]];
        _chanelTitle = [NSString stringWithFormat:@"%@",[snippetDictionary km_safeStringForKey:kchanelTitle]];
    }
}


@end
