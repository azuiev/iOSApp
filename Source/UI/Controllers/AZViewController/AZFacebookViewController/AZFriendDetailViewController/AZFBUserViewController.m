//
//  AZFBUserViewController.m
//  iOSApp
//
//  Created by Aleksey Zuiev on 18/09/2017.
//  Copyright © 2017 Aleksey Zuiev. All rights reserved.
//

#import "AZFBUserViewController.h"

#import "AZFBDownloadFriendsContext.h"
#import "AZFBFriendsViewController.h"
#import "AZFBDownloadFriendsContext.h"

#import "AZFriendView.h"

#import "AZMacros.h"
#import "AZGCD.h"

AZBaseViewControllerWithProperty(AZFBUserViewController, mainView, AZFriendView)
@interface AZFBUserViewController ()
@property (nonatomic, strong) AZFBDownloadFriendsContext *context;

@end

@implementation AZFBUserViewController

#pragma mark -
#pragma mark Accessors

- (void)setUser:(AZFBUserModel *)user {
    if (_user != user) {
        [_user removeObserver:self];
        
        _user = user;
        [_user addObserver:self];
        
        AZFBDownloadFriendsContext *context = [AZFBDownloadFriendsContext contextWithModel:_user];
        
        self.context = context;
    }
}

- (void)fillWithModel:(AZFBUserModel *)user {
    self.nameLabel.text = user.name;
    self.surnameLabel.text = user.surname;
    self.fatherNameLabel.text = user.fatherName;
    self.largeImageView.model = user.largeUserPicture;
    self.birthdayLabel.text = [NSString stringWithFormat:@"%@", user.birthday];
    self.emailLabel.text = user.email;
    self.genderLabel.text = user.gender;
}

- (void)prepareNavigationBar {
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Logout"
                                                                              style:UIBarButtonItemStyleDone
                                                                             target:self
                                                                             action:@selector(logout)];
}

#pragma mark -
#pragma mark Private methods

- (IBAction)presentFriends:(id)sender {
    AZFBUserModel *user = self.user;
    
    AZFBFriendsViewController *controller = [AZFBFriendsViewController new];
    controller.user = user;
    controller.friends = self.context.friends;
    
    [self.navigationController pushViewController:controller animated:YES];
    
    [self.context execute];
}

- (void)logout {
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark -
#pragma mark AZModelObserver

- (void)modelDidLoad:(AZFBUserModel *)model {
    [AZGCD dispatchAsyncOnMainQueue:^ {
        [self fillWithModel:model];
    }];
}


@end
