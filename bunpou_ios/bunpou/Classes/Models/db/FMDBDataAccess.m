

#import "FMDBDataAccess.h"
#import "FMDatabase.h"
#import "FMResultSet.h"
#import "ObjGrammar.h"
#import "Util.h"

#import "FMDatabaseAdditions.h"

#define DATABASE_FILE @"nguphapdb.sqlite"
#define SQL_FILE @"nguphapdb.sql"

@implementation FMDBDataAccess

#pragma mark -
#pragma mark - DATABASE handler

+ (NSString *) getFilePath:(NSString*)filePath
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *docsPath = [paths objectAtIndex:0];
    return [docsPath stringByAppendingPathComponent:filePath];
}

+ (void) copyDatabaseIfNeeded
{
	NSFileManager *fileManager = [NSFileManager defaultManager];
	NSError *error;
	NSString *dbPath = [self getFilePath:DATABASE_FILE];
    NSLog(@"---pathdb -%@",dbPath);
    
	BOOL success = [fileManager fileExistsAtPath:dbPath];
//    NSLog(@"---success -%d",success);
    
	if(!success) {
		NSString *defaultDBPath = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:DATABASE_FILE];
        NSLog(@"DB path = %@",defaultDBPath);
		success = [fileManager copyItemAtPath:defaultDBPath toPath:dbPath error:&error];
		
		if (!success) {
			NSAssert1(0, @"Failed to create writable database file with message '%@'.", [error localizedDescription]);
		}
	}
}


//run sql script
+ (void)runSqlFileScript
{
    FMDatabase *db = [FMDatabase databaseWithPath:[self getFilePath:DATABASE_FILE]];
    
    if (![db open]) {
        NSLog(@"Could not open db.");
        return;
    }
    
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"bunpou" ofType:@"sql"];
    NSString *query = [NSString stringWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:NULL];
    
    [db executeUpdate:query];
    [db close];
}

#pragma mark -
#pragma mark - Query methods

+(NSMutableArray *)getGrammarListByLevel:(NSInteger)level{
    NSMutableArray *resultList = [[NSMutableArray alloc] init];
    FMDatabase *db = [FMDatabase databaseWithPath:[self getFilePath:DATABASE_FILE]];
    if (![db open]) {
        NSLog(@"Could not open db.");
    }
    
    NSString* query = @"";
    
    switch (level) {
        case 1:
            query = @"SELECT * FROM np_n1 ";
            break;
        case 2:
            query = @"SELECT * FROM np_n2 ";
            break;
        case 3:
            query = @"SELECT * FROM np_n3 ";
            break;
        case 4:
            query = @"SELECT * FROM np_n4 ";
            break;
        case 5:
            query = @"SELECT * FROM np_n5 ";
            break;
        default:
            query = @"SELECT * FROM np_n5 ";
            break;
    }
    
    FMResultSet *rs = [db executeQuery:query];
    while ([rs next]) {
        ObjGrammar *objGrammar = [[ObjGrammar alloc] init];
        
        objGrammar.g_id = [rs intForColumn:@"id"];
        objGrammar.g_title = [rs stringForColumn:@"title"];
        objGrammar.g_content = [rs stringForColumn:@"contents"];
        
        //add to array
        [resultList addObject:objGrammar];
    }
    [db close];
    
    return resultList;
}

//http://www.brianjcoleman.com/framework-using-fmdb-to-communicate-with-sqlite-databases/
+(void)insertToHistory:(ObjGrammar*)obj{
    
    NSArray *docPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDir = [docPaths objectAtIndex:0];
    NSString *dbPath = [documentsDir   stringByAppendingPathComponent:DATABASE_FILE];
    
    FMDatabase *database = [FMDatabase databaseWithPath:dbPath];
    [database open];
    [database executeUpdate:@"INSERT INTO history (id, title, contents) VALUES (?, ?, ?)", [NSNumber numberWithInt:obj.g_id], [NSString stringWithFormat:@"%@", obj.g_title], [NSString stringWithFormat:@"%@", obj.g_content],nil];
    [database close];
    
}
+(void)insertToFavorite:(ObjGrammar*)obj{
    NSArray *docPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDir = [docPaths objectAtIndex:0];
    NSString *dbPath = [documentsDir   stringByAppendingPathComponent:DATABASE_FILE];
    
    FMDatabase *database = [FMDatabase databaseWithPath:dbPath];
    [database open];
    [database executeUpdate:@"INSERT INTO Like (id, title, contents) VALUES (?, ?, ?)", [NSNumber numberWithInt:obj.g_id], [NSString stringWithFormat:@"%@", obj.g_title], [NSString stringWithFormat:@"%@", obj.g_content],nil];
    [database close];
}

+(void)deleteFavoriteRecord:(ObjGrammar*)obj{
    NSArray *docPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDir = [docPaths objectAtIndex:0];
    NSString *dbPath = [documentsDir   stringByAppendingPathComponent:DATABASE_FILE];
    
    FMDatabase *database = [FMDatabase databaseWithPath:dbPath];
    [database open];
    [database executeUpdate:@"DELETE FROM like WHERE id = ?", [NSNumber numberWithInt:obj.g_id]];
    [database close];
}

+(BOOL)checkExitsReCor:(int)g_id{
    NSArray *docPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDir = [docPaths objectAtIndex:0];
    NSString *dbPath = [documentsDir   stringByAppendingPathComponent:DATABASE_FILE];
    
    FMDatabase *database = [FMDatabase databaseWithPath:dbPath];
    [database open];
    
    NSUInteger count = [database intForQuery:@"SELECT COUNT(id) FROM history WHERE id = ?",[NSNumber numberWithInt:g_id]];
    if(count > 0){
        return true;
    }else{
        return false;
    }
    
    [database close];
    
}



+(NSMutableArray *)getHistoryList{
    NSMutableArray *resultList = [[NSMutableArray alloc] init];
    FMDatabase *db = [FMDatabase databaseWithPath:[self getFilePath:DATABASE_FILE]];
    
    if (![db open]) {
        NSLog(@"Could not open db.");
    }
    
    NSString* query = @"SELECT * FROM history ";
    
    
    FMResultSet *rs = [db executeQuery:query];
    while ([rs next]) {
        ObjGrammar *objGrammar = [[ObjGrammar alloc] init];
        
        objGrammar.g_id = [rs intForColumn:@"id"];
        objGrammar.g_title = [rs stringForColumn:@"title"];
        objGrammar.g_content = [rs stringForColumn:@"contents"];
        
        //add to array
        [resultList addObject:objGrammar];
    }
    [db close];
    
    return resultList;
}

+(NSMutableArray *)getFavoriteList{
    NSMutableArray *resultList = [[NSMutableArray alloc] init];
    FMDatabase *db = [FMDatabase databaseWithPath:[self getFilePath:DATABASE_FILE]];
    NSLog(@"db --%@",db);
    if (![db open]) {
        NSLog(@"Could not open db.");
    }
    
    NSString* query = @"SELECT * FROM Like ";
    FMResultSet *rs = [db executeQuery:query];
    while ([rs next]) {
        ObjGrammar *objGrammar = [[ObjGrammar alloc] init];
        objGrammar.g_id = [rs intForColumn:@"id"];
        objGrammar.g_title = [rs stringForColumn:@"title"];
        objGrammar.g_content = [rs stringForColumn:@"contents"];
        
        //add to array
        [resultList addObject:objGrammar];
    }
    [db close];
    
    return resultList;
}

+(NSUInteger)countByLevel:(NSInteger)level{
    
    NSArray *docPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDir = [docPaths objectAtIndex:0];
    NSString *dbPath = [documentsDir   stringByAppendingPathComponent:DATABASE_FILE];
    
    FMDatabase *database = [FMDatabase databaseWithPath:dbPath];
    [database open];
    
    NSString* query = @"";
    
    switch (level) {
        case 1:
            query = @"SELECT COUNT(id) FROM np_n2 ";
            break;
        case 2:
            query = @"SELECT COUNT(id) FROM np_n2 ";
            break;
        case 3:
            query = @"SELECT COUNT(id) FROM np_n3 ";
            break;
        case 4:
            query = @"SELECT COUNT(id) FROM np_n4 ";
            break;
        case 5:
            query = @"SELECT COUNT(id) FROM np_n5 ";
            break;
        default:
            break;
    }

    
    NSUInteger numrc = [database intForQuery:query];
    NSLog(@"level %d -- %d",level,numrc);
    
    [database close];

    return numrc;
}

+(BOOL)checkExitsFavorite:(int)g_id{
    NSArray *docPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDir = [docPaths objectAtIndex:0];
    NSString *dbPath = [documentsDir   stringByAppendingPathComponent:DATABASE_FILE];
    
    FMDatabase *database = [FMDatabase databaseWithPath:dbPath];
    [database open];
    
    NSUInteger count = [database intForQuery:@"SELECT COUNT(id) FROM Like WHERE id = ?",[NSNumber numberWithInt:g_id]];
    if(count > 0){
        return true;
    }else{
        return false;
    }
    
    [database close];
    
}
@end