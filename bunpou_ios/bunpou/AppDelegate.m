//
//  AppDelegate.m
//  bunpou
//
//  Created by haimv-pc on 2014/02/24.
//  Copyright (c) 2014年 haimv-pc. All rights reserved.
//

#import "AppDelegate.h"
#import "GAI.h"
#import "iVersion.h"
#import "FMDBDataAccess.h"

//#import "MFSideMenuContainerViewController.h"
//#import "SideMenuViewController.h"

#import "MTSInitialSlidingViewController.h"
#import "Date.h"
#import "NotificationUtil.h"
#import "StartViewController.h"

static NSString *const kTrackingId=@"UA-48323261-2";

//FIX ME:
static NSString *const kAppId=@"UA-48323261-2";
static NSString *const kAppName=@"UA-48323261-2";



@implementation AppDelegate


@synthesize managedObjectContext = _managedObjectContext;
@synthesize managedObjectModel = _managedObjectModel;
@synthesize persistentStoreCoordinator = _persistentStoreCoordinator;

+ (void)initialize
{
    //set the bundle ID. normally you wouldn't need to do this
    //as it is picked up automatically from your Info.plist file
    //but we want to test with an app that's actually on the store
    [iVersion sharedInstance].applicationBundleID = @"com.mts.jlpt-grammar";
    
    //configure iVersion. These paths are optional - if you don't set
    //them, iVersion will just get the release notes from iTunes directly (if your app is on the store)
    //    [iVersion sharedInstance].remoteVersionsPlistURL = @"http://charcoaldesign.co.uk/iVersion/versions.plist";
    [iVersion sharedInstance].localVersionsPlistPath = @"versions.plist";
}


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    [NotificationUtil openNotificationAtDate:14];
    
    // reset applicationIconBadgeNumber
    application.applicationIconBadgeNumber = 0;
    //haimv - init database
    [FMDBDataAccess copyDatabaseIfNeeded];

    // Optional: automatically send uncaught exceptions to Google Analytics.
    [GAI sharedInstance].trackUncaughtExceptions = YES;
    
    // Optional: set Google Analytics dispatch interval to e.g. 20 seconds.
    [GAI sharedInstance].dispatchInterval = 20;
    
    // Optional: set Logger to VERBOSE for debug information.
    [[[GAI sharedInstance] logger] setLogLevel:kGAILogLevelVerbose];
    
    // Create tracker instance.
    [[GAI sharedInstance] trackerWithTrackingId:kTrackingId];
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    //call set root view controller
   [self setRootViewController];
    
    [self.window makeKeyAndVisible];
    return YES;
    
    //view detail exception
    NSSetUncaughtExceptionHandler(&uncaughtExceptionHandler);
}

- (void)setRootViewController
{
    self.window.rootViewController = nil;
    //StartViewController *startView = [[StartViewController alloc] initWithNibName:@"StartViewController" bundle:Nil];
    
    
    MTSInitialSlidingViewController *slidingViewController = [[MTSInitialSlidingViewController alloc] init];
    
    self.window.rootViewController = slidingViewController;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{

    /*
     Perform daily check for new version of your app
     Useful if user returns to you app from background after extended period of time
     Place in applicationDidBecomeActive:
     
     Also, performs version check on first launch.
     */
    [[Harpy sharedInstance] checkVersionDaily];
    
    /*
     Perform weekly check for new version of your app
     Useful if you user returns to your app from background after extended period of time
     Place in applicationDidBecomeActive:
     
     Also, performs version check on first launch.
     */
    [[Harpy sharedInstance] checkVersionWeekly];

}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

#pragma mark - Application's Documents directory

// Returns the URL to the application's Documents directory.
- (NSURL *)applicationDocumentsDirectory
{
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}


void uncaughtExceptionHandler(NSException *exception) {
    NSArray *backtrace = [exception callStackSymbols];
    NSLog(@"bug content : %@",backtrace);
}

-(void) checkNotification
{

}



@end
