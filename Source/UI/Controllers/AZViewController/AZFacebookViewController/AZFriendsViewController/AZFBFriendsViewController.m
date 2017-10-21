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
#import "AZFBUserDetailsContext.h"

#import "AZFriendsView.h"
#import "AZUserCell.h"

#import "AZGCD.h"
#import "AZMacros.h"

#import "UITableView+AZExtension.h"

AZBaseViewControllerWithProperty(AZFBFriendsViewController, mainView, AZFriendsView)
@interface AZFBFriendsViewController () <UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) AZFBUserDetailsContext    *context;

@end

@implementation AZFBFriendsViewController

#pragma mark -
#pragma mark Initialization

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self setTitle:@"Friends"];
}

#pragma mark -
#pragma mark Accessors

- (void)setFriends:(AZFBUsersModel *)friends {
    if  (_friends != friends) {
        
        _friends = friends;
        [self.mainView.tableView reloadData];
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
    [user addObserver:self];
    
    AZFBUserDetailsContext *context = [AZFBUserDetailsContext contextWithModel:user];
    self.context = context;
}

- (void)showViewController {
    AZFBUserViewController *friendController = [AZFBUserViewController new];
    friendController.user = self.context.user;
    [self.navigationController pushViewController:friendController animated:YES];
}

@end
