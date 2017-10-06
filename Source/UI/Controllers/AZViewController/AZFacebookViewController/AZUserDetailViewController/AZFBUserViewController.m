//
//  AZFBUserViewController.m
//  iOSApp
//
//  Created by Aleksey Zuiev on 18/09/2017.
//  Copyright © 2017 Aleksey Zuiev. All rights reserved.
//

#import "AZFBUserViewController.h"

#import "AZFBDownloadFriendsContext.h"
#import "AZFBFriendsViewController.h"
#import "AZFBDownloadFriendsContext.h"

#import "AZFriendView.h"

#import "AZMacros.h"
#import "AZGCD.h"

AZBaseViewControllerWithProperty(AZFBUserViewController, mainView, AZFriendView)
@interface AZFBUserViewController ()
@property (nonatomic, strong) AZFBDownloadFriendsContext *context;

@end

@implementation AZFBUserViewController

#pragma mark -
#pragma mark Accessors

- (void)setUser:(AZFBUserModel *)user {
    if (_user != user) {
        [_user removeObserver:self];
        
        _user = user;
        [_user addObserver:self];
        
        AZFBDownloadFriendsContext *context = [AZFBDownloadFriendsContext contextWithModel:[AZFBUsersModel new]
                                                                           completionState:AZModelDidLoad];
        context.user = _user;
        
        self.context = context;
    }
}

- (void)prepareNavigationBar {
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Logout"
                                                                              style:UIBarButtonItemStyleDone
                                                                             target:self
                                                                             action:@selector(onLogout)];
}

#pragma mark -
#pragma mark Private methods

- (IBAction)presentFriends:(id)sender {
    AZFBUserModel *user = self.user;
    
    AZFBFriendsViewController *controller = [AZFBFriendsViewController new];
    controller.user = user;
    controller.friends = (AZFBUsersModel *)self.context.model;
    
    [self.navigationController pushViewController:controller animated:YES];
    
    [self.context execute];
}

- (void)onLogout {
    [self dismissViewControllerAnimated:YES completion:nil];
    
    //Todo
    UIPresentationController *controller = self.presentationController;
}

#pragma mark -
#pragma mark AZModelObserver

- (void)modelDidLoad:(AZFBUserModel *)model {
    [AZGCD dispatchAsyncOnMainQueue:^ {
        [self.mainView fillWithModel:model];
    }];
}



@end
