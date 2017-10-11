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
#import "AZFBDownloadUserDetailsContext.h"

@interface AZFBLoginViewController ()
@property (nonatomic, strong) AZFBLoginContext      *loginContext;
@property (nonatomic, strong) AZFBUserModel         *user;
@end

@implementation AZFBLoginViewController

#pragma mark -
#pragma mark Initialization and deallocation

- (void)viewDidAppear:(BOOL)animated {
    if (self.loginContext.accessToken) {
        //[self presentChildController];
    }
}

#pragma mark -
#pragma mark Accessors

- (void)setLoginContext:(AZFBLoginContext *)loginContext {
    if (_loginContext != loginContext) {
        [_loginContext cancel];
        
        _loginContext = loginContext;
        [loginContext execute];
     }
}

- (void)setUser:(AZFBUserModel *)user {
    if (_user != user) {
        [_user removeObserver:self];
        
        _user = user;
        [_user addObserver:self];
    }
}

- (IBAction)loginToFacebook:(id)sender {
    AZFBUserModel *fbUser = [AZFBUserModel new];
    self.user = fbUser;
    self.loginContext = [AZFBLoginContext contextWithModel:fbUser];
}

#pragma mark -
#pragma mark Public Methods 

- (void)logout {
    [self.loginContext logout];
}

#pragma mark -
#pragma mark Observer 

- (void)modelDidLoad:(AZModel *)model {
    AZFBUserViewController *controller = [AZFBUserViewController new];
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:controller];
    controller.user = self.user;
    self.user = nil;
    
    [self presentViewController:navigationController animated:YES completion:nil];
}

@end
