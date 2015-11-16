//
//  CategoriesEntity.h
//  ViTuBe
//
//  Created by haimv on 2015/11/05.
//  Copyright © 2015年 haimv. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CategoriesEntity : NSObject

@property (nonatomic, copy) NSString* categoryId;
@property (nonatomic, copy) NSString* chanelId;
@property (nonatomic, copy) NSString* chanelTitle;

- (id)initWithDictionary:(NSDictionary*)dictionary ;

@end
