//
//  AZFBLoginViewController.m
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

@interface AZFBLoginViewController ()
@property (nonatomic, strong) AZFBLoginContext    *context;
@end

@implementation AZFBLoginViewController
#pragma mark -
#pragma mark Initialization and deallocation

- (instancetype)init {
    self = [super init];
    if (self) {
        self.context = [AZFBLoginContext contextWithModel:self];
    }
    
    return self;
}

- (void)viewDidAppear:(BOOL)animated {
    if (self.context.accessToken) {
        //[self presentChildController];
    }
}

- (IBAction)loginToFacebook:(id)sender {
    [self.context execute];
}

- (void)presentChildController {
    AZFBUserViewController *controller = [AZFBUserViewController new];
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:controller];
    [self presentViewController:navigationController animated:YES completion:nil];
    
    FBSDKAccessToken *appToken = self.context.accessToken;
    controller.user = [AZFBUserModel userWithID:appToken.userID accessToken:appToken.tokenString];
}

@end
