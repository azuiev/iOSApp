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

@interface AZFBLoginContext ()
@property (nonatomic, readonly) AZFBUserModel   *user;

@end

@implementation AZFBLoginContext

@dynamic user;

#pragma mark -
#pragma mark Accessors 

- (AZFBUserModel *)user {
    return (AZFBUserModel *)self.model;
}

#pragma mark -
#pragma mark Private Methods

- (void)fillUserWithResponse:(id)result {
    AZFBUserModel *user = self.user;
    NSString *token = [result valueForKeyPath:AZTokenStringPath];
    NSString *userID = [result valueForKeyPath:AZUserIDStringPath];
    [user setValue:token forKey:AZTokenString];
    [user setValue:userID forKey:AZUserIDString];
}

#pragma mark -
#pragma mark Overrided methods

- (void)executeWithCompletionHandler:(void (^)(AZModelState))completionHandler {
    FBSDKLoginManager *login = [FBSDKLoginManager new];
    [login logInWithReadPermissions:@[@"public_profile", @"email", @"user_friends"]
                 fromViewController:nil
                            handler:^(FBSDKLoginManagerLoginResult *result, NSError *error) {
                                if (error) {
                                    NSLog(@"Process error");
                                } else if (result.isCancelled) {
                                    NSLog(@"Cancelled");
                                } else {
                                    NSLog(@"Logged in");
                                    
                                    [self fillUserWithResponse:result];
                                    
                                    completionHandler(AZModelDidLoad);
                                }
                            }];
}

@end
