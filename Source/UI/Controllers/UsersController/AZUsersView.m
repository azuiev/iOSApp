//
//  AZUsersView.m
//  iOSApp
//
//  Created by Aleksey Zuiev on 11/07/2017.
//  Copyright © 2017 Aleksey Zuiev. All rights reserved.
//

#import "AZUsersView.h"

#import "AZUserCell.h"

@implementation AZUsersView

- (void)setEditing:(BOOL)editing animated:(BOOL)animated {
    [self.tableView setEditing:editing animated:animated];
}

- (AZUser *)getUserByIndexPath:(NSIndexPath *)indexPath {
    AZUserCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
    
    return cell.user;
}

@end
