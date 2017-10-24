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
#import "AZFBFriendsContext.h"

#import "AZFriendsView.h"
#import "AZUserCell.h"

#import "AZGCD.h"
#import "AZMacros.h"

#import "UITableView+AZExtension.h"

AZBaseViewControllerWithProperty(AZFBFriendsViewController, mainView, AZFriendsView)
@interface AZFBFriendsViewController () <UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong)   AZFBFriendsContext  *friendsContext;

@end

@implementation AZFBFriendsViewController

@dynamic friendsContext;
@dynamic friends;

#pragma mark -
#pragma mark Initialization and Deallocation

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setTitle:@"Friends"];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    self.friendsContext = [AZFBFriendsContext contextWithModel:self.friends user:self.user];
}

#pragma mark -
#pragma mark Accessors

- (AZFBUsersModel *)friends {
    return (AZFBUsersModel *)self.model;
}

- (void)setFriends:(AZFBUsersModel *)friends {
    self.model = friends;
}

- (AZFBFriendsContext *)friendsContext {
    return (AZFBFriendsContext *)self.context;
}

- (void)setFriendsContext:(AZFBFriendsContext *)friendsContext {
    self.context = friendsContext;
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
    AZFBUserViewController *controller = [AZFBUserViewController new];
    controller.currentUser = self.currentUser;
    controller.user = self.friends[indexPath.row];
    
    [self.navigationController pushViewController:controller animated:YES];
}

#pragma mark -
#pragma mark Model Observer

- (void)modelDidLoad:(AZModel *)model {
    [AZGCD dispatchAsyncOnMainQueue:^ {
        [self.mainView.loadingView setVisible:NO];
        [self.mainView.tableView reloadData];
    }];
}

@end
