//
//  AZFBCurrentUser.m
//  iOSApp
//
//  Created by Aleksey Zuiev on 27/10/2017.
//  Copyright © 2017 Aleksey Zuiev. All rights reserved.
//

#import <FBSDKLoginKit/FBSDKLoginKit.h>
#import <FBSDKCoreKit/FBSDKCoreKit.h>

#import "AZFBCurrentUser.h"

@implementation AZFBCurrentUser

#pragma mark -
#pragma mark Initialization and Deallocation

+ (instancetype)userWithID:(NSString *)userID accessToken:(NSString *)accessToken {
    return [[self alloc] initWithID:userID accessToken:accessToken];;
}

#pragma mark -
#pragma mark Initialization

- (instancetype)initWithID:(NSString *)userID accessToken:(NSString *)accessToken {
    self = [super initWithID:userID];
    if (self) {
        self.token = accessToken;
    }
    
    return self;
}

#pragma mark -
#pragma mark Public methods

- (BOOL)isLogged {
    FBSDKAccessToken *accessToken = [FBSDKAccessToken currentAccessToken];
    
    return ([self.userID isEqualToString:accessToken.userID]);
}

- (void)clearToken {
    self.token = nil;
}

@end
