//
//  AppDelegate.m
//  ecomap
//
//  Created by Anton Kovernik on 02.02.15.
//  Copyright (c) 2015 SoftServe. All rights reserved.
//

#import "AppDelegate.h"
#import <GoogleMaps/GoogleMaps.h>
#import "CocoaLumberjack.h"
#import "EcomapFetcher.h"
#import <FacebookSDK/FacebookSDK.h>

//Setup DDLog
#import "GlobalLoggerLevel.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    [GMSServices provideAPIKey:@"AIzaSyC8CqCUnyZX516O08J6JUCTV03ySVQAZoI"];

    //Configurate lamberjack
    [DDLog addLogger:[DDASLLogger sharedInstance]]; //DDASLLogger (sends log statements to Apple System Logger, so they show up on Console.app)
    [DDLog addLogger:[DDTTYLogger sharedInstance]]; //DDTTYLogger (sends log statements to Xcode console - if available)
    
    //DDFileLogger (sends log statements to a file)
    //The code tells the application to keep a week's worth of log files on the system.
    DDFileLogger *fileLogger = [[DDFileLogger alloc] init];
    fileLogger.rollingFrequency = 60 * 60 * 24; // 24 hour rolling
    fileLogger.logFileManager.maximumNumberOfLogFiles = 7;
    [DDLog addLogger:fileLogger];
    //Log files aare at
    //~/Library/Application Support/iPhone Simulator//Applications//Library/Caches/. As you can see, the path might be slightly different depending on which version of the iOS Simulator you are using/
    //It should now have a folder named Logs containing one text file named log-XXXXXX.txt.
    //Keep in mind that he Caches directory can be emptied by the operating system at any time. If you want to store your application's log files in a safer location, then I suggest storing them in the application's Documents directory.

    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    
    //Hadle in case when the user leaves the app while the login dialog is visible either in Facebook app or in Safari. In such a case, it’s necessary to use the Facebook framework for doing some cleanup and removing any unfinished session processes.
    [FBAppCall handleDidBecomeActive];
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    // Saves changes in the application's managed object context before the application terminates.
}

#pragma mark - Facebook
//This one is called after the login credentials entry and app authorization have finished in Facebook app or Safari.

-(BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation{
    //This manages the results of all the actions taken outside the app (successful login/authorization or cancelation), and properly directs the login flow back in our app again.
    return [FBAppCall handleOpenURL:url sourceApplication:sourceApplication];
}


@end
