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

#import "AZGCD.h"
#import "AZMacros.h"

AZBaseViewControllerWithProperty(AZFBLoginViewController, mainView, AZFBLoginView)
@interface AZFBLoginViewController ()
@property (nonatomic, strong) AZFBLoginContext      *loginContext;

- (void)showUserController;

@end

@implementation AZFBLoginViewController

@synthesize currentUser = _currentUser;
@dynamic loginContext;

#pragma mark -
#pragma mark Initialization and deallocation

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.currentUser = [AZFBCurrentUser new];
}

#pragma mark -
#pragma mark Accessors

- (AZFBLoginContext *)loginContext {
    return (AZFBLoginContext *)self.context;
}

- (void)setLoginContext:(AZFBLoginContext *)loginContext {
    self.context = loginContext;
}

- (void)setCurrentUser:(AZFBCurrentUser *)currentUser {
    if (_currentUser != currentUser) {
        [_currentUser removeObserver:self];
        
        _currentUser = currentUser;
        [_currentUser addObserver:self];
    }
}

#pragma mark -
#pragma mark Interface Handling

- (IBAction)onLogin:(id)sender {
    self.loginContext = [AZFBLoginContext contextWithModel:self.currentUser];
}

#pragma mark -
#pragma mark Override Methods

- (void)prepareNavigationBar {
    
}

- (void)showUserController {
    AZFBCurrentUser *user = self.currentUser;
    AZFBUserViewController *controller = [AZFBUserViewController new];
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:controller];
    controller.model = user;
    controller.currentUser = user;
    
    [self presentViewController:navigationController animated:YES completion:nil];
}

- (void)modelDidLoad:(AZModel *)model {
    [AZGCD dispatchAsyncOnMainQueue:^ {
        [self showUserController];
    }];
}

@end
