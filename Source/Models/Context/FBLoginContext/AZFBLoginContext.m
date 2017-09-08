//
//  AZFBLoginContext.m
//  iOSApp
//
//  Created by Aleksey Zuiev on 07/09/2017.
//  Copyright © 2017 Aleksey Zuiev. All rights reserved.
//

#import <FBSDKLoginKit/FBSDKLoginKit.h>
#import <FBSDKCoreKit/FBSDKCoreKit.h>

#import "AZFBLoginContext.h"

@interface AZFBLoginContext ()
@property (nonatomic, strong) UIViewController *controller;

@end

@implementation AZFBLoginContext

+ (instancetype)contextWithViewController:(UIViewController *)controller {
    return [[self alloc] initWithController:controller];
}

- (instancetype)initWithController:(UIViewController *)controller {
    self = [super init];
    if (self) {
        self.controller = controller;
    }
    
    return self;
}

- (void)execute {
    FBSDKLoginManager *login = [[FBSDKLoginManager alloc] init];
    [login logInWithReadPermissions:@[@"public_profile"]
                 fromViewController:(UIViewController *)self.controller
                            handler:^(FBSDKLoginManagerLoginResult *result, NSError *error) {
                                if (error) {
                                    NSLog(@"Process error");
                                } else if (result.isCancelled) {
                                    NSLog(@"Cancelled");
                                } else {
                                    NSLog(@"Logged in");
                                }
                            }];
}

@end
