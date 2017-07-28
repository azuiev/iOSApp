//
//  AZUsersViewController.m
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

AZBaseViewControllerWithProperty(AZUsersViewController, usersView, AZUsersView);
@interface AZUsersViewController () <UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, assign) UITableViewCellEditingStyle   editingStyle;

@end

@implementation AZUsersViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

#pragma mark -
#pragma mark Accessors 

- (void)setUsers:(AZArrayModel *)users {
    if  (_users != users) {
        [_users removeObserver:self];
        
        _users = users;
        [_users addObserver:self];
    }
}

#pragma mark -
#pragma mark UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.users count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    Class clazz = [AZUserCell class];
    
    AZUserCell *cell = [tableView cellWithClass:clazz];
    
    cell.user = self.users[indexPath.row];
    
    return cell;
}

- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath
      toIndexPath:(NSIndexPath *)destinationIndexPath {
    [self.users moveRowWithoutNotificationFromIndex:sourceIndexPath.row
                                            toIndex:destinationIndexPath.row];
    
}

#pragma mark -
#pragma mark UITableViewDelegate

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
    return self.editingStyle;
}

- (IBAction)insertUser:(id)sender {
    AZArrayModel *model = self.users;
    [model insertObject:[AZUser new] atIndex:AZRandomNumberWithMaxValue(model.count)];
}

- (IBAction)removeUser:(id)sender {
    AZArrayModel *model = self.users;
    [model removeObjectAtIndex:AZRandomNumberWithMaxValue(model.count - 1)];
}

- (IBAction)changeMoveMode:(id)sender {
    self.editingStyle = UITableViewCellEditingStyleNone;
    [self.usersView changeEditMode];
}

- (IBAction)changeEditMode:(id)sender {
    self.editingStyle = UITableViewCellEditingStyleInsert;
    [self.usersView changeEditMode];
}

- (IBAction)changeDeleteMode:(id)sender {
    self.editingStyle = UITableViewCellEditingStyleDelete;
    [self.usersView changeEditMode];
}

- (void)    tableView:(UITableView *)tableView
   commitEditingStyle:(UITableViewCellEditingStyle)editingStyle
    forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (UITableViewCellEditingStyleDelete == editingStyle) {
        [self.users removeObjectAtIndex:indexPath.row];
    }
    
    if (UITableViewCellEditingStyleInsert == editingStyle) {
        [self.users insertObject:[AZUser new] atIndex:indexPath.row];
    }
    
    [self.usersView changeEditMode];
}

#pragma mark -
#pragma mark AZArrayModelObserver

- (void)arrayModelObjectRemoved:(AZArrayModel *)arrayModel options:(AZArrayModelOptions *)options {
    NSNumber *row = [[options modelOptions] firstObject];
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:[row intValue] inSection:0];
    [self.usersView.tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath]
                                    withRowAnimation: UITableViewRowAnimationFade];
}

- (void)arrayModelObjectAdded:(AZArrayModel *)arrayModel options:(AZArrayModelOptions *)options {
    NSNumber *row = [[options modelOptions] firstObject];
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:[row intValue] inSection:0];
    [self.usersView.tableView insertRowsAtIndexPaths:[NSArray arrayWithObject:indexPath]
                                    withRowAnimation: UITableViewRowAnimationFade];
}

@end
