//
//  AZFriendView.m
//  iOSApp
//
//  Created by Aleksey Zuiev on 18/09/2017.
//  Copyright © 2017 Aleksey Zuiev. All rights reserved.
//

#import "AZFriendView.h"
#import "AZFBUserModel.h"

@implementation AZFriendView

- (void)fillWithModel:(AZFBUserModel *)user {
    self.nameLabel.text = user.name;
    self.surnameLabel.text = user.surname;
    self.fatherNameLabel.text = user.fatherName;
    self.largeImageView.model = user.largeUserPicture;
    self.birthdayLabel.text = [NSString stringWithFormat:@"%@", user.birthday];
    self.emailLabel.text = user.email;
    self.genderLabel.text = user.gender;
}

@end
