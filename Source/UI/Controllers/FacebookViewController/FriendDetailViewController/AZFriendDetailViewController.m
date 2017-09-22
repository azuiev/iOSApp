//
//  AZFriendDetailViewController.m
//  iOSApp
//
//  Created by Aleksey Zuiev on 18/09/2017.
//  Copyright © 2017 Aleksey Zuiev. All rights reserved.
//

#import "AZFriendDetailViewController.h"

#import "AZFBDownloadFriendDetailsContext.h"

#import "AZFriendView.h"

#import "AZMacros.h"
#import "AZGCD.h"

AZBaseViewControllerWithProperty(AZFriendDetailViewController, mainView, AZFriendView)
@interface AZFriendDetailViewController () <UITableViewDelegate, UITableViewDataSource>

@end

@implementation AZFriendDetailViewController

- (void)viewWillAppear:(BOOL)animated {
    [self.navigationController setTitle:self.friend.name];
    
    [self fillWithModel:self.friend];
}

#pragma mark -
#pragma mark Accessors

- (void)setFriend:(AZFBUserModel *)friend {
    if (_friend != friend) {
        [_friend removeObserver:self];
        
        _friend = friend;
        [_friend addObserver:self];
    }
    
    [self fillWithModel:friend];
    [[AZFBDownloadFriendDetailsContext contextWithModel:friend] execute];
}

- (void)fillWithModel:(AZFBUserModel *)user {
    self.nameLabel.text = user.name;
    self.surnameLabel.text = user.surname;
    self.fatherNameLabel.text = user.fatherName;
    self.friendImageView.model = user.largeUserPicture;
    self.birthdayLabel.text = [NSString stringWithFormat:@"%@", user.birthday];
    self.emailLabel.text = user.email;
    self.genderLabel.text = user.gender;
}

#pragma mark -
#pragma mark AZModelObserver

- (void)modelDidLoad:(AZFBUserModel *)model {
    [AZGCD dispatchAsyncOnMainQueue:^ {
        [self fillWithModel:model];
    }];
}

@end
