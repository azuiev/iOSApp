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

NSString *appID = @"240815836441068";
NSString *appSecret = @"KYOIvMEMaTixlYL4SL4v09Hqoxc";

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
    
    //create users cache
    

    FBSDKGraphRequest *requestToken = [[FBSDKGraphRequest alloc]
                                       initWithGraphPath:[NSString stringWithFormat:@"%@%@", appID, @"/accounts/test-users"]
                                       parameters:@{@"fields":@"access_token"}
                                       tokenString:[NSString stringWithFormat:@"%@%s%@", appID, "|", appSecret]
                                       version:nil
                                       HTTPMethod:@"GET"];
    
    [requestToken startWithCompletionHandler:^(FBSDKGraphRequestConnection *connection,
                                               id result,
                                               NSError *error)
     {
         NSDictionary *users = [result valueForKey:@"data"];
         for (NSDictionary *user in users) {
             NSString *userID = [user valueForKey:@"id"];
             NSString *token = [user valueForKey:@"access_token"];
             
             [AZFBUserModel userWithID:userID accessToken:token];
         }
     }];
  
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
