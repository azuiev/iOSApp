//
//  AZFriendDetailViewController.m
//  iOSApp
//
//  Created by Aleksey Zuiev on 18/09/2017.
//  Copyright © 2017 Aleksey Zuiev. All rights reserved.
//

#import "AZFriendDetailViewController.h"

#import "AZDownloadFriendDetailsContext.h"

#import "AZFriendView.h"
#import "AZMacros.h"

AZBaseViewControllerWithProperty(AZFriendDetailViewController, mainView, AZFriendView)
@interface AZFriendDetailViewController () <UITableViewDelegate, UITableViewDataSource>

@end

@implementation AZFriendDetailViewController

- (void)viewWillAppear:(BOOL)animated {
    self.navigationController.title =self.friend.fullName;
    
    [self fillWithModel:self.friend];
}

#pragma mark -
#pragma mark Accessors

- (void)setFriend:(AZFBUserModel *)friend {
    if (_friend != friend) {
        _friend = friend;
    }
    
    [[AZDownloadFriendDetailsContext contextWithModel:friend] execute];
    [self fillWithModel:friend];
}

- (void)fillWithModel:(AZFBUserModel *)user {
    self.nameLabel.text = user.name;
    self.surnameLabel.text = user.surname;
    self.friendImageView.model = user.largeUserPicture;
}

@end
