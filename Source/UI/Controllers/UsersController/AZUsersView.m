//
//  AZUsersView.m
//  iOSApp
//
//  Created by Aleksey Zuiev on 11/07/2017.
//  Copyright © 2017 Aleksey Zuiev. All rights reserved.
//

#import "AZUsersView.h"

#import "AZUserCell.h"

#import "UINib+AZExtension.h"+

@implementation AZUsersView

#pragma mark -
#pragma mark Public Methods

- (void)changeEditMode {
    UITableView *view = self.tableView;
    [view setEditing:![view isEditing] animated:YES];
}

@end
