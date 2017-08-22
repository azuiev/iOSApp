//
//  AZmainViewController.m
//  iOSApp
//
//  Created by Aleksey Zuiev on 11/07/2017.
//  Copyright © 2017 Aleksey Zuiev. All rights reserved.
//

#import "AZUsersViewController.h"

#import "AZUsersView.h"
#import "AZUserCell.h"

#import "AZMacros.h"
#import "UITableView+AZExtension.h"

#import "AZRandomNumber.h"

#import "AZArrayModelChange.h"
#import "AZArrayModelAddChange.h"
#import "AZArrayModelRemoveChange.h"
#import "AZArrayModelMoveChange.h"

#import "AZGCD.h"

AZBaseViewControllerWithProperty(AZUsersViewController, mainView, AZUsersView);
@interface AZUsersViewController () <UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, assign) UITableViewCellEditingStyle       editingStyle;

- (NSString *)plistName;

@end

@implementation AZUsersViewController

#pragma mark -
#pragma mark Accessors 

- (void)setUsers:(AZUsersModel *)users {
    if  (_users != users) {
        [_users removeObserver:self];
        
        _users = users;
        [_users addObserver:self];
        
        [_users load];
    }
}

#pragma mark -
#pragma mark UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.users.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    AZUserCell *cell = [tableView reusableCellWithClass:[AZUserCell class]];
    cell.user = self.users[indexPath.row];
    
    return cell;
}

- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath
      toIndexPath:(NSIndexPath *)destinationIndexPath
{
    [self.users moveFromIndex:sourceIndexPath.row
                      toIndex:destinationIndexPath.row];
}

#pragma mark -
#pragma mark UITableViewDelegate

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
    return self.editingStyle;
}

- (void)    tableView:(UITableView *)tableView
   commitEditingStyle:(UITableViewCellEditingStyle)editingStyle
    forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (UITableViewCellEditingStyleDelete == editingStyle) {
        [self.users removeObjectAtIndex:indexPath.row];
    }
    
    if (UITableViewCellEditingStyleInsert == editingStyle) {
        [self.users insertObject:[AZUserModel new] atIndex:indexPath.row];
    }
    
    [self.mainView changeEditMode];
}

#pragma mark -
#pragma mark Buttons Actions

- (IBAction)insertUser:(id)sender {
    AZUsersModel *model = self.users;
    [model insertObject:[AZUserModel new] atIndex:AZRandomNumberWithMaxValue(model.count)];
}

- (IBAction)removeUser:(id)sender {
    AZUsersModel *model = self.users;
    [model removeObjectAtIndex:AZRandomNumberWithMaxValue(model.count - 1)];
}

- (IBAction)changeMoveMode:(id)sender {
    self.editingStyle = UITableViewCellEditingStyleNone;
    [self.mainView changeEditMode];
}

- (IBAction)changeEditMode:(id)sender {
    self.editingStyle = UITableViewCellEditingStyleInsert;
    [self.mainView changeEditMode];
}

- (IBAction)changeDeleteMode:(id)sender {
    self.editingStyle = UITableViewCellEditingStyleDelete;
    [self.mainView changeEditMode];
}

#pragma mark -
#pragma mark AZModelObserver

- (void)modelDidLoad:(AZModel *)model {
    [AZGCD dispatchAsyncOnMainQueue: ^ {
        [self.mainView.loadingView setVisible:NO];
        
        [self.mainView.tableView reloadData];
    }];
}

- (void)modelWillLoad:(AZModel *)model {
    [AZGCD dispatchAsyncOnMainQueue: ^ {
        [self.mainView.loadingView setVisible:YES];
    }];
}

- (void)modelDidUnload:(AZModel *)model {
    [AZGCD dispatchAsyncOnMainQueue: ^ {
        [self.mainView.loadingView setVisible:NO];
    }];
}

- (void)modelDidFailLoad:(AZModel *)model {
    
}

#pragma mark -
#pragma mark AZArrayModelObserver

- (void)arrayModelDidChange:(AZArrayModel *)arrayModel withObject:(AZArrayModelChange *)object {
    [self.mainView.tableView applyChangesWithObject:object];
}

@end
