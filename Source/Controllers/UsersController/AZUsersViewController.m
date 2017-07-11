//
//  AZUsersViewController.m
//  iOSApp
//
//  Created by Aleksey Zuiev on 11/07/2017.
//  Copyright © 2017 Aleksey Zuiev. All rights reserved.
//

#import "AZUsersViewController.h"

#import "AZUsersView.h"
#import "AZUsersViewCell.h"

#import "AZMacros.h"

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
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString * const AZReuseIdentifier = @"AZReuseIdentifier";
    
    AZUsersViewCell *cell = [[AZUsersViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                                   reuseIdentifier:AZReuseIdentifier];
    
    cell.textLabel.text = @"Test";
    
    return cell;
}



@end
