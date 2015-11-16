//
//  SourceConfig.m
//  ViTuBe
//
//  Created by haimv on 2015/11/05.
//  Copyright © 2015年 haimv. All rights reserved.
//

#import "SourceConfig.h"
#import "KM_NSDictionary+SafeValues.h"


#define kConfigVersionKey @"version"
#define kConfigBuildKey @"build"
#define kConfigHostKey @"api_host"
#define kConfigApiKey @"api_key"


@implementation SourceConfig

+ (SourceConfig*)config{
    static dispatch_once_t onceToken;
    static SourceConfig* instance = nil;
    dispatch_once(&onceToken, ^{
        instance = [[SourceConfig alloc] init];
    });
    return instance;
}

- (id) init{
    self = [super init];
    if (self){
        NSBundle* bundle = [NSBundle bundleForClass:[self class]];
        NSDictionary* config = [[NSDictionary alloc]initWithContentsOfFile:[bundle pathForResource:@"KMSourceConfig" ofType:@"plist"]];
        _theMovieDbHost = [config km_safeStringForKey:kConfigHostKey];
        _version = [config km_safeStringForKey:kConfigVersionKey];
        _build = [config km_safeStringForKey:kConfigBuildKey];
        _apiKey = [config km_safeStringForKey:kConfigApiKey];
    }
    return self;
}
@end
