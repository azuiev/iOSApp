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
@property (nonatomic, strong) AZFBFriendsContext    *context;
@property (nonatomic, strong) AZFBUsersModel        *friends;
@end

@implementation AZFBUserViewController

@synthesize user = _user;

#pragma mark -
#pragma mark Initialization and Deallocation

- (void)dealloc {
    self.friends = nil;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.friends = [AZFBUsersModel new];
}

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

- (void)setFriends:(AZFBUsersModel *)friends {
    if (_friends != friends) {
        [_friends removeObserver:self];
        
        _friends = friends;
        [_friends addObserver:self];
    }
}

#pragma mark -
#pragma mark Interface handling

- (IBAction)onFriends {
    [self startLoadingFriends];
}

#pragma mark -
#pragma mark Private methods

- (void)startLoadingFriends {
    AZFBFriendsContext *context = [AZFBFriendsContext contextWithModel:self.friends];
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
