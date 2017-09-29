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
#import "AZFBDownloadFriendsContext.h"

#import "AZFriendsView.h"
#import "AZUserCell.h"

#import "AZGCD.h"
#import "AZMacros.h"

#import "UITableView+AZExtension.h"

AZBaseViewControllerWithProperty(AZFBFriendsViewController, mainView, AZFriendsView)
@interface AZFBFriendsViewController () <UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) AZFBDownloadFriendsContext *context;
@end

@implementation AZFBFriendsViewController

#pragma mark -
#pragma mark Initialization

- (void)viewWillAppear:(BOOL)animated {
    [self setTitle:@"Friends"];
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

- (void)setUser:(AZFBUserModel *)user {
    if (_user != user) {
        _user = user;
        AZFBDownloadFriendsContext *context = [AZFBDownloadFriendsContext contextWithModel:user];
        context.controller = self;
        self.context = context;
        
        [context execute];
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
    
    AZFBUserViewController *friendController = [[AZFBUserViewController alloc] initWithNibName:@"AZFBUserViewController"
                                                                                                   bundle:nil];
    friendController.user = user;
        
    [self.navigationController pushViewController:friendController animated:YES];
}

#pragma mark -
#pragma mark AZModelObserver

- (void)modelDidLoad:(AZModel *)model {
    [AZGCD dispatchAsyncOnMainQueue:^ {
        [self.mainView.loadingView setVisible:NO];
        [self.mainView.tableView reloadData];
    }];
}

@end
