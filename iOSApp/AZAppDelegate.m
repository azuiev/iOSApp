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
#import "AZArrayModel.h"

#import "UIWindow+AZExtension.h"
#import "NSArray+AZExtension.h"

static NSString *AZPlistName = @"app.plist";

@interface AZAppDelegate ()

@end

@implementation AZAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    UIWindow *window = [UIWindow window];
    self.window = window;
    
    AZUsersViewController *controller = [AZUsersViewController new];
    //AZSquareViewController *controller = [AZSquareViewController new];
    
    window.rootViewController = controller;
    window.backgroundColor = [UIColor purpleColor];
    
    [self load];
    
    [window makeKeyAndVisible];
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    [self save];
    
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    [self load];
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    [self save];
}

#pragma mark -
#pragma mark Public

- (void)save {
    AZUsersViewController *controller = (AZUsersViewController *)self.window.rootViewController;
    
    [NSKeyedArchiver archiveRootObject:controller.users toFile:[self plistName]];
}

- (void)load {
    AZUsersViewController *controller = (AZUsersViewController *)self.window.rootViewController;
    
    AZArrayModel *users = [NSKeyedUnarchiver unarchiveObjectWithFile:[self plistName]];
    if (!users) {
        users = [AZArrayModel new];
    }
    
    [controller setUsers:users];
}

#pragma mark -
#pragma mark Private

- (NSString *)plistName {
    NSArray *paths = NSSearchPathForDirectoriesInDomains (NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *result = [paths firstObject];
    
    result = [result stringByAppendingPathComponent:AZPlistName];
    
    return result;
}

@end
