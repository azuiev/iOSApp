//
//  AZFBUserViewController.m
//  iOSApp
//
//  Created by Aleksey Zuiev on 18/09/2017.
//  Copyright © 2017 Aleksey Zuiev. All rights reserved.
//

#import "AZFBUserViewController.h"

#import "AZFBFriendsContext.h"
#import "AZFBFriendsViewController.h"
#import "AZFBFriendsContext.h"

#import "AZFBUserView.h"

#import "AZMacros.h"
#import "AZGCD.h"

AZBaseViewControllerWithProperty(AZFBUserViewController, mainView, AZFBUserView)
@interface AZFBUserViewController ()
@property (nonatomic, strong) AZFBFriendsContext *context;

@end

@implementation AZFBUserViewController

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    [self.mainView fillWithModel:self.user];
}

#pragma mark -
#pragma mark Accessors

- (void)setUser:(AZFBUserModel *)user {
    if (_user != user) {
        _user = user;
        
        [self.mainView fillWithModel:user];
    }
}

#pragma mark -
#pragma mark Private methods

- (IBAction)onFriends {
    AZFBUsersModel *friends = [AZFBUsersModel new];
    [friends addObserver:self];
    AZFBFriendsContext *context = [AZFBFriendsContext contextWithModel:friends];
    context.user = self.user;
    self.context = context;
}

#pragma mark -
#pragma mark Override Methods

- (void)showViewController {
    AZFBFriendsViewController *controller = [AZFBFriendsViewController new];
    [self.navigationController pushViewController:controller animated:YES];
    controller.friends = self.context.friends;
}

@end
