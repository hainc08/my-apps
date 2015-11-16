//
//  SourceConfig.h
//  ViTuBe
//
//  Created by haimv on 2015/11/05.
//  Copyright © 2015年 haimv. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SourceConfig : NSObject

+ (SourceConfig*)config;

@property (nonatomic, copy, readonly) NSString* version;
@property (nonatomic, copy, readonly) NSString* build;
@property (nonatomic, copy, readonly) NSString* theMovieDbHost;
@property (nonatomic, copy, readonly) NSString* apiKey;

@end
