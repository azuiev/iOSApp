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
#import "AZFBLoginView.h"

#import "AZFBLoginContext.h"
#import "AZFBUserDetailsContext.h"

#import "AZGCD.h"
#import "AZMacros.h"

AZBaseViewControllerWithProperty(AZFBLoginViewController, mainView, AZFBLoginView)
@interface AZFBLoginViewController ()
@property (nonatomic, strong) AZFBLoginContext      *loginContext;
@property (nonatomic, strong) AZFBUserModel         *user;

@end

@implementation AZFBLoginViewController

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

#pragma mark -
#pragma mark Interface Handling

- (IBAction)onLoginButton:(id)sender {
    AZFBUserModel *user = [AZFBUserModel new];
    self.user = user;
    self.loginContext = [AZFBLoginContext contextWithModel:user];
}

#pragma mark -
#pragma mark Override Methods

- (void)prepareNavigationBar {
    
}

- (void)showViewController {
    AZFBUserViewController *controller = [AZFBUserViewController new];
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:controller];
    AZFBUserModel *user = self.user;
    [self presentViewController:navigationController animated:YES completion:^ {
        controller.user = user;
    }];
}

@end
