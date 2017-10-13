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

@implementation AZFBLogoutContext

#pragma mark -
#pragma mark Overrided methods

- (void)execute {
    FBSDKLoginManager *loginManager = [FBSDKLoginManager new];
    
    [loginManager logOut];
}

@end
