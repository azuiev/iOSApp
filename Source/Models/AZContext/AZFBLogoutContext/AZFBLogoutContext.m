//
//  AZFBLogoutContext.m
//  iOSApp
//
//  Created by Aleksey Zuiev on 12/10/2017.
//  Copyright © 2017 Aleksey Zuiev. All rights reserved.
//

#import <FBSDKLoginKit/FBSDKLoginKit.h>
#import <FBSDKCoreKit/FBSDKCoreKit.h>

#import "AZFBLogoutContext.h"
#import "AZFBUserModel.h"

@implementation AZFBLogoutContext

#pragma mark -
#pragma mark Overrided methods

- (void)executeWithCompletionHandler:(void (^)(AZModelState))completionHandler {
    FBSDKLoginManager *loginManager = [FBSDKLoginManager new];
    
    [loginManager logOut];
    
    completionHandler(AZModelDidUnload);
}

@end
