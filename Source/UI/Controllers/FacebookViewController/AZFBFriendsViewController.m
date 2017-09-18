//
//  AZFBFriendsViewController.m
//  iOSApp
//
//  Created by Aleksey Zuiev on 11/09/2017.
//  Copyright © 2017 Aleksey Zuiev. All rights reserved.
//

#import "AZFBFriendsViewController.h"
#import "AZFriendDetailViewController.h"

#import "AZFriendsView.h"
#import "AZFBUserModel.h"
#import "AZUserCell.h"


#import "AZGCD.h"
#import "AZMacros.h"
#import "UITableView+AZExtension.h"


AZBaseViewControllerWithProperty(AZFBFriendsViewController, mainView, AZFriendsView)
@interface AZFBFriendsViewController () <UITableViewDelegate, UITableViewDataSource>

@end

@implementation AZFBFriendsViewController


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

- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath
      toIndexPath:(NSIndexPath *)destinationIndexPath
{
    [self.friends moveFromIndex:sourceIndexPath.row
                      toIndex:destinationIndexPath.row];
}

#pragma mark -
#pragma mark UITableViewDelegate

- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath {
    AZUserCell *cell = (AZUserCell *)[tableView cellForRowAtIndexPath:indexPath];
    AZFBUserModel *user = (AZFBUserModel *)cell.user;
    
    AZFriendDetailViewController *friendController = [[AZFriendDetailViewController alloc]initWithNibName:@"AZFriendDetailViewController"
                                                                                                   bundle:nil];
    friendController.friend = user;
    
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
