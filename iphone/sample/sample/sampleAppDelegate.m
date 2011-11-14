//
//  sampleAppDelegate.m
//  sample
//
//  Created by Mujtaba Mehdi on 9/15/11.
//  Copyright 2011 http://www.codesignerror.com All rights reserved.
//


#import "sampleAppDelegate.h"
#import "Global.h"
#import "sampleViewController.h"

@implementation sampleAppDelegate


@synthesize window=_window;
@synthesize facebook;

NSString * const FacebookAppID = AppIDAPI;
NSString * const facebookAccessTokenKey = @"facebookAccessToken";
NSString * const facebookExpirationDateKey = @"facebookExpirationDate";

@synthesize viewController=_viewController;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    isFirstScan = 1;
    NSUserDefaults * defs = [NSUserDefaults standardUserDefaults];
    
    facebook = [[Facebook alloc] initWithAppId:FacebookAppID];
    facebook.accessToken = [defs stringForKey:facebookAccessTokenKey];
    facebook.expirationDate = [defs objectForKey:facebookExpirationDateKey];    
    

    // Override point for customization after application launch.
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:self.viewController];
    self.window.rootViewController = nav;
    [self.window makeKeyAndVisible];
    return YES;
}

- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url {
    BOOL ret = [facebook handleOpenURL:url]; 
    NSLog(@"%d",ret);
	return ret;
}


- (void)applicationWillResignActive:(UIApplication *)application
{
    /*
     Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
     Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
     */
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    /*
     Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
     If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
     */
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    /*
     Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
     */
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    /*
     Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
     */
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    /*
     Called when the application is about to terminate.
     Save data if appropriate.
     See also applicationDidEnterBackground:.
     */
}

- (void)dealloc
{
    [_window release];
    [_viewController release];
    [super dealloc];
}

@end
