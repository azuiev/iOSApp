//
//  AZFBFriendsViewController.m
//  iOSApp
//
//  Created by Aleksey Zuiev on 11/09/2017.
//  Copyright © 2017 Aleksey Zuiev. All rights reserved.
//

#import "AZFBFriendsViewController.h"
#import "AZFBUserViewController.h"

#import "AZFBUserModel.h"
#import "AZFBDownloadUserDetailsContext.h"

#import "AZFriendsView.h"
#import "AZUserCell.h"

#import "AZGCD.h"
#import "AZMacros.h"

#import "UITableView+AZExtension.h"

AZBaseViewControllerWithProperty(AZFBFriendsViewController, mainView, AZFriendsView)
@interface AZFBFriendsViewController () <UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) AZFBDownloadUserDetailsContext *context;

@end

@implementation AZFBFriendsViewController

#pragma mark -
#pragma mark Initialization

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self setTitle:@"Friends"];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    self.user = nil;
    self.friends = nil;
}

#pragma mark -
#pragma mark Accessors

- (void)setFriends:(AZFBUsersModel *)friends {
    if  (_friends != friends) {
        [_friends removeObserver:self];
        
        _friends = friends;
        [_friends addObserver:self];
        
        [_friends load];
    }
}

#pragma mark -
#pragma mark UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.friends.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    AZUserCell *cell = [tableView reusableCellWithClass:[AZUserCell class]];
    cell.user = self.friends[indexPath.row];
    
    return cell;
}

#pragma mark -
#pragma mark UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    AZFBUserModel *user = self.friends[indexPath.row];
    AZFBUserViewController *friendController = [AZFBUserViewController new];
    friendController.user = user;
        
    [self.navigationController pushViewController:friendController animated:YES];
    
    AZFBDownloadUserDetailsContext *context = [AZFBDownloadUserDetailsContext contextWithModel:user];
    self.context = context;
    
    [context execute];
    
}

#pragma mark -
#pragma mark AZModelObserver

- (void)modelWillLoad:(AZModel *)model {
    [AZGCD dispatchAsyncOnMainQueue:^ {
        [self.mainView.loadingView setVisible:YES];
    }];
}

- (void)modelDidLoad:(AZModel *)model {
    [AZGCD dispatchAsyncOnMainQueue:^ {
        [self.mainView.loadingView setVisible:NO];
        [self.mainView.tableView reloadData];
    }];
}

@end
