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

- (void)setUser:(AZUser *)user {
    if (_user != user) {
        _user = user;
        
        [self fillWithModel:user];
    }
}

- (void)fillWithModel:(AZUser *)user {
    self.fullNameLabel.text = user.fullName;
    self.userImageView.imageModel = user.imageModel;
}

#pragma mark -
#pragma mark Override

- (void)prepareForReuse {
    [super prepareForReuse];
    
    self.user = nil;
}

@end
