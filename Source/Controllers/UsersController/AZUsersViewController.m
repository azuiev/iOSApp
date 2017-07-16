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
#import "UINib+AZExtension.h"

AZBaseViewControllerWithProperty(AZUsersViewController, usersView, AZUsersView);
@interface AZUsersViewController ()

@end

@implementation AZUsersViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

#pragma mark -
#pragma mark UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 2000;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    Class clazz = [AZUserCell class];
    
    AZUserCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass(clazz)];
    if (!cell) {
        UINib *nib = [UINib nibWithClass:clazz];
        cell = [nib cellWithClass:clazz];
    }
    
    cell.user = [AZUser new];
    return cell;
}

@end
