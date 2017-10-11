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
#import "AZFBDownloadUserDetailsContext.h"

NSString *AZTokenStringPath     = @"token.tokenString";
NSString *AZUserIDStringPath    = @"token.userID";

@interface AZFBLoginContext ()
@property (nonatomic, strong) AZFBDownloadUserDetailsContext    *userContext;

@end

@implementation AZFBLoginContext

@dynamic accessToken;

#pragma mark -
#pragma mark Public methods

- (FBSDKAccessToken * )accessToken {
    return [FBSDKAccessToken currentAccessToken];
}

- (void)logout {
    [[FBSDKLoginManager new] logOut];
}

#pragma mark -
#pragma mark Accessors 

- (void)setUserContext:(AZFBDownloadUserDetailsContext *)userContext {
    if (_userContext != userContext) {
        [_userContext cancel];
        
        _userContext = userContext;
        [_userContext executeWithSettingState];
    }
}

#pragma mark -
#pragma mark Overrided methods

- (void)execute {
    FBSDKLoginManager *login = [FBSDKLoginManager new];
    [login logOut];
    [login logInWithReadPermissions:@[@"public_profile", @"email", @"user_friends"]
                 fromViewController:nil
                            handler:^(FBSDKLoginManagerLoginResult *result, NSError *error) {
                                if (error) {
                                    NSLog(@"Process error");
                                } else if (result.isCancelled) {
                                    NSLog(@"Cancelled");
                                } else {
                                    NSLog(@"Logged in");
                                    AZFBUserModel *user = (AZFBUserModel *)self.model;
                                    NSString *token = [result valueForKeyPath:AZTokenStringPath];
                                    NSString *userID = [result valueForKeyPath:AZUserIDStringPath];
                                    
                                    [user setValue:token forKey:@"token"];
                                    [user setValue:userID forKey:@"userID"];
                                    
                                    self.model.state = AZModelDidLoad;
                                    
                                    self.userContext = [AZFBDownloadUserDetailsContext contextWithModel:user];
                                }
                            }];
}

@end
