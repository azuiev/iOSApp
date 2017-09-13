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

@interface AZFBLoginContext ()
@property (nonatomic, strong) AZFBLoginViewController   *controller;

@end

@implementation AZFBLoginContext

#pragma mark -
#pragma mark Class methods

@dynamic accessToken;

+ (instancetype)contextWithViewController:(AZFBLoginViewController *)controller {
    return [[self alloc] initWithController:controller];
}

#pragma mark -
#pragma mark Initialization and Deallocation

- (instancetype)initWithController:(AZFBLoginViewController *)controller {
    self = [super init];
    if (self) {
        self.controller = controller;
    }
    
    return self;
}

#pragma mark -
#pragma mark Public methods

- (FBSDKAccessToken * )accessToken {
    return [FBSDKAccessToken currentAccessToken];
}

#pragma mark -
#pragma mark Overrided methods

- (void)execute {
    FBSDKLoginManager *login = [[FBSDKLoginManager alloc] init];
    [login logInWithReadPermissions:@[@"public_profile", @"email", @"user_friends"]
                 fromViewController:(UIViewController *)self.controller
                            handler:^(FBSDKLoginManagerLoginResult *result, NSError *error) {
                                if (error) {
                                    NSLog(@"Process error");
                                } else if (result.isCancelled) {
                                    NSLog(@"Cancelled");
                                } else {
                                    NSLog(@"Logged in");
                                    [self.controller presentChildController];
                                }
                            }];
}

@end
