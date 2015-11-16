//
//  FMDBDataAccess.h
//
//  Created by haimv on 1/10/13.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ObjGrammar.h"


@interface FMDBDataAccess : NSObject{
    
}

+ (void) copyDatabaseIfNeeded;

+(NSMutableArray *)getGrammarListByLevel:(NSInteger)level;
+(void)insertToHistory:(ObjGrammar*)obj;
+(void)insertToFavorite:(ObjGrammar*)obj;
+(BOOL)checkExitsReCor:(int)g_id;
+(NSMutableArray *)getHistoryList;
+(NSMutableArray *)getFavoriteList;
+(NSUInteger)countByLevel:(NSInteger)level;
+(BOOL)checkExitsFavorite:(int)g_id;
+(void)deleteFavoriteRecord:(ObjGrammar*)obj;

@end
