//
//  BaseSource.h
//  ViTuBe
//
//  Created by haimv on 2015/11/05.
//  Copyright © 2015年 haimv. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BaseSource : NSObject


@property (nonatomic, strong) NSOperationQueue* operationQueue;
- (NSDictionary*)dictionaryFromResponseData:(NSData*)responseData jsonPatternFile:(NSString*)jsonFile;


@end
