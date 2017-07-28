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

AZBaseViewControllerWithProperty(AZUsersViewController, usersView, AZUsersView);
@interface AZUsersViewController () <UITableViewDelegate, UITableViewDataSource>

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

#pragma mark -
#pragma mark UITableViewDelegate

- (void)    tableView:(UITableView *)tableView
 didEndDisplayingCell:(AZUserCell *)cell
    forRowAtIndexPath:(NSIndexPath *)indexPath
{
    cell.user = nil;
}

- (IBAction)enableEditMode:(id)sender {
    [self.usersView setEditing:YES animated:YES];
}

- (void)    tableView:(UITableView *)tableView
   commitEditingStyle:(UITableViewCellEditingStyle)editingStyle
    forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (UITableViewCellEditingStyleDelete == editingStyle) {
        [self.users removeObjectAtIndex:indexPath.row];
        
        [self.usersView setEditing:NO animated:YES];
    }
}

#pragma mark -
#pragma mark AZArrayModelObserver

- (void)arrayModelObjectRemoved:(AZArrayModel *)arrayModel options:(AZArrayModelOptions *)options {
    NSNumber *row = [[options modelOptions] firstObject];
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:[row intValue] inSection:0];
    [self.usersView.tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath]
                     withRowAnimation: UITableViewRowAnimationFade];
}

@end
