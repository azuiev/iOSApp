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

#pragma mark -
#pragma mark Accessors

- (void)setUser:(AZFBUserModel *)user {
    if (_user != user) {
        [_user removeObserver:self];
        
        _user = user;
        [_user addObserver:self];
    }
}

- (void)setContext:(AZFBFriendsContext *)context {
    if (_context != context) {
        [_context cancel];
        
        _context = context;
        _context.user = self.user;
        [_context execute];
    }
}

#pragma mark -
#pragma mark Private methods

- (IBAction)presentFriends:(id)sender {
    AZFBUsersModel *friends = [AZFBUsersModel new];
    AZFBFriendsViewController *controller = [AZFBFriendsViewController new];
    controller.friends = friends;
    
    self.context = [AZFBFriendsContext contextWithModel:friends];
    
    [self.navigationController pushViewController:controller animated:YES];
    
}

@end
