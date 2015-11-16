//
//  VideoCategoriesSource.m
//  ViTuBe
//
//  Created by haimv on 2015/11/05.
//  Copyright © 2015年 haimv. All rights reserved.
//

#import "VideoCategoriesSource.h"
#import "SourceConfig.h"

#import "CategoriesEntity.h"

//#define kVideoCategoriesUrlFormat @"%@/videoCategories/?part=snippet&regionCode=US&fields=items(id,snippet(title))&key=%@"
#define kVideoCategoriesUrlFormat @"%@/videoCategories/?part=snippet&regionCode=US&fields=items&key=%@"

@implementation VideoCategoriesSource


#pragma mark -
#pragma mark Init Methods

+ (VideoCategoriesSource*)categoriesSource;
{
    static dispatch_once_t onceToken;
    static VideoCategoriesSource* instance = nil;
    dispatch_once(&onceToken, ^{
        instance = [[VideoCategoriesSource alloc]init];
    });
    return instance;
}


#pragma mark -
#pragma mark Request Methods

- (void)getCategoriesList:(NSString*)pageLimit completion:(CategoryListCompletionBlock)completionBlock;
{
    if (completionBlock)
    {
        NSDictionary* parameters = [[NSDictionary alloc] initWithObjects:[NSArray arrayWithObjects:pageLimit, nil] forKeys:[NSArray arrayWithObjects:@"page", nil]];
        
        [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
        
        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
        [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Accept"];
        
        [manager GET:[self prepareUrl] parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject)
         {
            NSLog(@"JSON: %@", responseObject);
             NSDictionary* infosDictionary = [responseObject objectForKey:@"items"];
             dispatch_async(dispatch_get_main_queue(), ^{
                 [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
                 completionBlock([self processResponseObject:infosDictionary], nil);
             });
         }
             failure:^(AFHTTPRequestOperation *operation, NSError *error)
         {
             NSLog(@"Error: %@", error);
             dispatch_async(dispatch_get_main_queue(), ^{
                 [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
                 NSString* errorString = error.localizedDescription;
                 if ([errorString length] == 0)
                     errorString = nil;
                 completionBlock(nil, errorString);
             });
         }];
    }
}

#pragma mark -
#pragma mark Data Parsing

- (NSArray*)processResponseObject:(NSDictionary*)data
{
    if (data == nil)
        return nil;
//    NSArray* itemsList = [NSArray arrayWithArray:[data objectForKey:@"items"]];
    NSMutableArray* sortedArray = [[NSMutableArray alloc] init];
    for (NSDictionary* item in data)
    {
        CategoriesEntity* categories = [[CategoriesEntity alloc] initWithDictionary:item];
        [sortedArray addObject:categories];
    }
    return sortedArray;
}



#pragma mark -
#pragma mark Private

- (NSString*)prepareUrl
{
    NSLog(@"load url %@",[NSString stringWithFormat:kVideoCategoriesUrlFormat, [SourceConfig config].theMovieDbHost, [SourceConfig config].apiKey]);
    return [NSString stringWithFormat:kVideoCategoriesUrlFormat, [SourceConfig config].theMovieDbHost, [SourceConfig config].apiKey];
}


@end
