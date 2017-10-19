//
//  AZUserCell.m
//  iOSApp
//
//  Created by Aleksey Zuiev on 11/07/2017.
//  Copyright © 2017 Aleksey Zuiev. All rights reserved.
//

#import "AZUserCell.h"

@implementation AZUserCell

#pragma mark -
#pragma mark Accessors

- (void)setUser:(AZUserModel *)user {
    if (_user != user) {
        _user = user;
    }
    
    [self fillWithModel:user];
}

- (void)fillWithModel:(AZUserModel *)user {
    self.fullNameLabel.text = user.fullName;
    self.userImageView.model = user.userPicture;
}

#pragma mark -
#pragma mark Override

- (void)prepareForReuse {
    [super prepareForReuse];
    
    self.userImageView.contentImageView.image = nil;
}

@end
