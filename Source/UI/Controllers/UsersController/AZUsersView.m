//
//  AZUsersView.m
//  iOSApp
//
//  Created by Aleksey Zuiev on 11/07/2017.
//  Copyright © 2017 Aleksey Zuiev. All rights reserved.
//

#import "AZUsersView.h"

#import "AZUserCell.h"

#import "UINib+AZExtension.h"

@implementation AZUsersView

#pragma mark -
#pragma mark Initialization

- (void)awakeFromNib {
    [super awakeFromNib];
    
    if (!self.loadingView) {
        [self initSubviews];
    }
}

- (void)initSubviews {
    AZLoadingView *view = [UINib objectWithClass:[AZLoadingView class]];
    [view addAsSubiew:self bounds:self.bounds];
    
    self.loadingView = view;
}

#pragma mark -
#pragma mark Public Methods

- (void)changeEditMode {
    UITableView *view = self.tableView;
    [view setEditing:![view isEditing] animated:YES];
}

@end
