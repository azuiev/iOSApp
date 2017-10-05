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
@property (nonatomic, strong) AZFBLoginContext                      *loginContext;
@property (nonatomic, strong) AZFBDownloadUserDetailsContext        *userContext;
@property (nonatomic, strong) AZFBUserModel                         *user;

@end

@implementation AZFBLoginViewController

#pragma mark -
#pragma mark Initialization and deallocation

- (instancetype)init {
    self = [super init];
    if (self) {
        AZFBUserModel *user = [AZFBUserModel new];
        self.user = user;
        self.loginContext = [AZFBLoginContext contextWithModel:user];
        self.userContext = [AZFBDownloadUserDetailsContext contextWithModel:user];
    }
    
    return self;
}

- (void)viewDidAppear:(BOOL)animated {
    if (self.loginContext.accessToken) {
        //[self presentChildController];
    }
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

- (IBAction)loginToFacebook:(id)sender {
    [self.loginContext execute];
}

#pragma mark -
#pragma mark Observer

- (void)modelWillLoad:(AZModel *)model {
    AZFBUserViewController *controller = [AZFBUserViewController new];
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:controller];
    [self presentViewController:navigationController animated:YES completion:nil];
    
    controller.user = self.user;
    [self.userContext execute];
}

@end
