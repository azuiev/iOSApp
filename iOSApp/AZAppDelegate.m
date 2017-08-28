//
//  AZAppDelegate.m
//  iOSApp
//
//  Created by Aleksey Zuiev on 30/06/2017.
//  Copyright © 2017 Aleksey Zuiev. All rights reserved.
//

#import "AZAppDelegate.h"
#import "AZSquareViewController.h"
#import "AZUsersViewController.h"
#import "AZUsersModel.h"

#import "UIWindow+AZExtension.h"
#import "NSArray+AZExtension.h"

@interface AZAppDelegate ()

@end

@implementation AZAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    UIWindow *window = [UIWindow window];
    self.window = window;
    
    AZUsersViewController *controller = [AZUsersViewController new];
    //AZSquareViewController *controller = [AZSquareViewController new];
    AZUsersModel *users = [AZUsersModel new];
    
    controller.users = users;
    
    window.rootViewController = controller;
    window.backgroundColor = [UIColor purpleColor];
    
    [window makeKeyAndVisible];
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    [[NSNotificationCenter defaultCenter] postNotificationName:@"AZSaveNotification" object:self];
    
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    [[NSNotificationCenter defaultCenter] postNotificationName:@"AZLoadNotification" object:self];
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
     [[NSNotificationCenter defaultCenter] postNotificationName:@"AZSaveNotification" object:self];
}

@end
