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
#import "AZFBUserViewController.h"
#import "AZFBLoginContext.h"
#import "AZFBUserDetailsContext.h"

static NSString *AZTokenStringPath     = @"token.tokenString";
static NSString *AZUserIDStringPath    = @"token.userID";
static NSString *AZUserIDString        = @"userID";
static NSString *AZTokenString         = @"token";
static NSString *AZPublicProfileKey    = @"public_profile";
static NSString *AZUserFriendsKey      = @"user_friends";

@implementation AZFBLoginContext

#pragma mark -
#pragma mark Private Methods

- (void)fillUserWithResponse:(id)result {
    AZFBCurrentUser *user = self.currentUser;
    NSString *token = [result valueForKeyPath:AZTokenStringPath];
    NSString *userID = [result valueForKeyPath:AZUserIDStringPath];
    
    [user setValue:token forKey:AZTokenString];
    [user setValue:userID forKey:AZUserIDString];
}

#pragma mark -
#pragma mark Overrided methods

- (void)executeWithCompletionHandler:(void (^)(AZModelState))completionHandler {
    if (![self.currentUser isLogged]) {
        FBSDKLoginManager *login = [FBSDKLoginManager new];
        [login logInWithReadPermissions:@[AZPublicProfileKey, AZUserFriendsKey]
                     fromViewController:nil
                                handler:^(FBSDKLoginManagerLoginResult *result, NSError *error) {
                                    if (error) {
                                        NSLog(@"Process error");
                                    } else if (result.isCancelled) {
                                        NSLog(@"Cancelled");
                                    } else {
                                        [self fillUserWithResponse:result];
                                        
                                        completionHandler(AZModelDidLoad);
                                    }
                                }];
    } else {
        completionHandler(AZModelDidLoad);
    }
}

@end
