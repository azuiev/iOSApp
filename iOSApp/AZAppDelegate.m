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
#import "AZFBLoginViewController.h"

#import "AZUsersModel.h"
#import "AZFBUserModel.h"

#import "UIWindow+AZExtension.h"
#import "NSArray+AZExtension.h"

#import <FBSDKCoreKit/FBSDKCoreKit.h>

@interface AZAppDelegate ()

@end

@implementation AZAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    [[FBSDKApplicationDelegate sharedInstance] application:application
                             didFinishLaunchingWithOptions:launchOptions];
    
    UIWindow *window = [UIWindow window];
    self.window = window;
    
//    AZSquareViewController *controller = [AZSquareViewController new];
//    AZUsersViewController *controller = [AZUsersViewController new];
//    AZUsersModel *users = [AZUsersModel new];
//    
//    controller.users = users;
    
    AZFBLoginViewController *controller = [AZFBLoginViewController new];
    
    window.rootViewController = controller;
    window.backgroundColor = [UIColor purpleColor];
    
    [window makeKeyAndVisible];
    
    [[FBSDKApplicationDelegate sharedInstance] application:application
                             didFinishLaunchingWithOptions:launchOptions];
    
    return YES;
}

- (BOOL)application:(UIApplication *)application
            openURL:(NSURL *)url
  sourceApplication:(NSString *)sourceApplication
         annotation:(id)annotation
{
    BOOL handled = [[FBSDKApplicationDelegate sharedInstance] application:application
                                                                  openURL:url
                                                        sourceApplication:sourceApplication
                                                               annotation:annotation];

    return handled;
}

- (void)applicationWillResignActive:(UIApplication *)application {

}

- (void)applicationDidEnterBackground:(UIApplication *)application {
   
    
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
   
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {

}

@end
