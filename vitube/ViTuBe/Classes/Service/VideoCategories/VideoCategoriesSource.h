//
//  VideoCategoriesSource.h
//  ViTuBe
//
//  Created by haimv on 2015/11/05.
//  Copyright © 2015年 haimv. All rights reserved.
//

#import "BaseSource.h"



typedef void (^CategoryListCompletionBlock)(NSArray* data, NSString* errorString);
@interface VideoCategoriesSource : BaseSource

+ (VideoCategoriesSource*)categoriesSource;
- (void)getCategoriesList:(NSString*)pageLimit completion:(CategoryListCompletionBlock)completionBlock;


@end
