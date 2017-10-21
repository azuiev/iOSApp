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
@property (nonatomic, strong) AZFBLoginContext      *context;

@end

@implementation AZFBLoginViewController

@synthesize user = _user;

#pragma mark -
#pragma mark Initialization and deallocation

- (void)dealloc {
    self.user =  nil;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.user = [AZFBUserModel new];
}

#pragma mark -
#pragma mark Accessors

- (void)setUser:(AZFBUserModel *)user {
    if (_user != user) {
        [_user removeObserver:self];
        
        _user = user;
        [_user addObserver:self];
    }
}

#pragma mark -
#pragma mark Interface Handling

- (IBAction)onLogin:(id)sender {
    self.context = [AZFBLoginContext contextWithModel:self.user];
}

#pragma mark -
#pragma mark Override Methods

- (void)prepareNavigationBar {
    
}

- (void)showViewController {
    AZFBUserModel *user = self.user;
    AZFBUserViewController *controller = [AZFBUserViewController new];
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:controller];
    
    [self presentViewController:navigationController animated:YES completion:^ {
        controller.user = user;
    }];
}

@end
