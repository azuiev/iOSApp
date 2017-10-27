//
//  AZFBUserParser.m
//  iOSApp
//
//  Created by Aleksey Zuiev on 19/10/2017.
//  Copyright © 2017 Aleksey Zuiev. All rights reserved.
//

#import "AZFBUserParser.h"

static NSString *AZUserNameKey              = @"first_name";
static NSString *AZUserSurnameKey           = @"last_name";
static NSString *AZUserMiddleNameKey        = @"middle_name";
static NSString *AZUserGenderKey            = @"gender";
static NSString *AZUserBirthdayKey          = @"birthday";
static NSString *AZUserPictureURLKey        = @"picture.data.url";
static NSString *AZUserPictureKey           = @"userPicture";
static NSString *AZUserIDKey                = @"id";
static NSString *AZUserName                 = @"name";
static NSString *AZUserSurname              = @"surname";
static NSString *AZUserMiddleName           = @"middleName";

@implementation AZFBUserParser

+ (void)updateUser:(AZFBUserModel *)user withObject:(id)object {
    NSURL *imageURL = [NSURL URLWithString:[object valueForKeyPath:AZUserPictureURLKey]];
    AZImageModel *imageModel = [AZImageModel imageModelWithURL:imageURL];
    [user setValue:imageModel forKey:AZUserPictureKey];
    [user setValue:[object valueForKey:AZUserNameKey] forKey:AZUserName];
    [user setValue:[object valueForKey:AZUserSurnameKey] forKey:AZUserSurname];
    [user setValue:[object valueForKey:AZUserGenderKey] forKey:AZUserGenderKey];
    [user setValue:[object valueForKey:AZUserBirthdayKey] forKey:AZUserBirthdayKey];
    [user setValue:[object valueForKey:AZUserMiddleNameKey] forKey:AZUserMiddleName];
}

+ (AZFBUserModel *)userWithObject:(id)object {
    NSString *userID = [object valueForKey:AZUserIDKey];
    AZFBUserModel *user = [AZFBUserModel userWithID:userID];

    [self updateUser:user withObject:object];
    
    return user;
}

@end
