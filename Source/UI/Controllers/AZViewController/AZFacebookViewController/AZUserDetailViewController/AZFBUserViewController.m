//
//  AZFBUserViewController.m
//  iOSApp
//
//  Created by Aleksey Zuiev on 18/09/2017.
//  Copyright © 2017 Aleksey Zuiev. All rights reserved.
//

#import "AZFBUserViewController.h"

#import "AZFBFriendsViewController.h"
#import "AZFBUserDetailsContext.h"

#import "AZFBUserView.h"

#import "AZMacros.h"
#import "AZGCD.h"

AZBaseViewControllerWithProperty(AZFBUserViewController, mainView, AZFBUserView)
@interface AZFBUserViewController ()
@property (nonatomic, strong)   AZFBUserDetailsContext      *userContext;
- (void)showFriendsController;

@end

@implementation AZFBUserViewController

@dynamic userContext;

#pragma mark -
#pragma mark Initialization and Deallocation

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    self.userContext = [AZFBUserDetailsContext contextWithModel:self.model];
}

#pragma mark -
#pragma mark Accessors

- (AZFBUserModel *)user {
    return (AZFBUserModel *)self.model;
}

- (void)setUser:(AZFBUserModel *)user {
    self.model = user;
}

- (AZFBUserDetailsContext *)userContext {
    return (AZFBUserDetailsContext *)self.context;
}

- (void)setUserContext:(AZFBUserDetailsContext *)userContext {
    self.context = userContext;
}

#pragma mark -
#pragma mark Interface handling

- (IBAction)onFriends {
    [self showFriendsController];
}

#pragma mark -
#pragma mark Private Methods

- (void)showFriendsController {
    AZFBFriendsViewController *controller = [AZFBFriendsViewController new];
    controller.currentUser = self.currentUser;
    controller.friends = [AZFBUsersModel new];
    controller.user = self.user;
    
    [self.navigationController pushViewController:controller animated:YES];
}

@end
