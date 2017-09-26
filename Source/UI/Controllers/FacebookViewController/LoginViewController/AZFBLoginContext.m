//
//  AZFBLoginContext.m
//  iOSApp
//
//  Created by Aleksey Zuiev on 07/09/2017.
//  Copyright © 2017 Aleksey Zuiev. All rights reserved.
//

#import <FBSDKLoginKit/FBSDKLoginKit.h>
#import <FBSDKCoreKit/FBSDKCoreKit.h>

#import "AZFBLoginViewController.h"
#import "AZFBLoginContext.h"

@implementation AZFBLoginContext

@dynamic accessToken;

#pragma mark -
#pragma mark Public methods

- (FBSDKAccessToken * )accessToken {
    return [FBSDKAccessToken currentAccessToken];
}

#pragma mark -
#pragma mark Overrided methods

- (void)execute {
    FBSDKLoginManager *login = [[FBSDKLoginManager alloc] init];
    [login logOut];
    [login logInWithReadPermissions:@[@"public_profile", @"email", @"user_friends"]
                 fromViewController:(UIViewController *)self.model
                            handler:^(FBSDKLoginManagerLoginResult *result, NSError *error) {
                                if (error) {
                                    NSLog(@"Process error");
                                } else if (result.isCancelled) {
                                    NSLog(@"Cancelled");
                                } else {
                                    NSLog(@"Logged in");
                                    [(AZFBLoginViewController *)self.model presentChildController];
                                }
                            }];
}

@end
