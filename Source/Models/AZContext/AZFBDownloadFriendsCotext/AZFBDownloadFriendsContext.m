//
//  AZFBDownloadFriendsContext.m
//  iOSApp
//
//  Created by Aleksey Zuiev on 13/09/2017.
//  Copyright © 2017 Aleksey Zuiev. All rights reserved.
//

#import "AZFBDownloadFriendsContext.h"

#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import <FBSDKLoginKit/FBSDKLoginKit.h>
#import <FBSDKShareKit/FBSDKShareKit.h>

#import "AZFBUserModel.h"

#import "AZRandomNumber.h"

NSString *AZFriendsGraphPath            = @"/me/friends";
NSString *AZFriendsParametersKey        = @"fields";
NSString *AZFriendsParametersValue      = @"id,name,picture{url}";
NSString *AZFriendsNameKey              = @"name";
NSString *AZFriendsSurnameKey           = @"surname";
NSString *AZFriendsFatherNameKey        = @"fatherName";
NSString *AZFriendsDataKey              = @"data";
NSString *AZFriendsIDKey                = @"id";
NSString *AZFriendsTotalCountKey        = @"summary.total_count";
NSString *AZFriendsPictureURLKey        = @"picture.data.url";
NSString *AZFriendsPictureKey           = @"smallUserPicture";

@implementation AZFBDownloadFriendsContext

@dynamic token;

#pragma mark -
#pragma mark Initialization and Deallocation

- (instancetype)initWithModel:(AZModel *)model {
    self = [super initWithModel:model];
    if (self) {
        self.graphPath  = AZFriendsGraphPath;
        self.parameters = @{AZFriendsParametersKey:AZFriendsParametersValue};
    }
    
    return self;
}

#pragma mark -
#pragma mark Overrided methods

- (void)fillModelWithResponse:(id)result {
    NSNumber *count = [result valueForKeyPath:AZFriendsTotalCountKey];
    
    NSMutableArray *fbUsers = [NSMutableArray arrayWithCapacity:[count integerValue]];
    NSDictionary *users = [result valueForKey:AZFriendsDataKey];
    for (NSDictionary *user in users) {
        NSString *userID = [user valueForKey:AZFriendsIDKey];
        NSURL *imageURL = [NSURL URLWithString:[user valueForKeyPath:AZFriendsPictureURLKey]];
        AZImageModel *imageModel = [AZImageModel imageModelWithURL:imageURL];
        NSArray *names = [[user valueForKey:AZFriendsNameKey] componentsSeparatedByString:@" "];
        
        AZFBUserModel *fbUser = [AZFBUserModel userWithID:userID];
        [fbUser setValue:names[0] forKey:AZFriendsNameKey];
        [fbUser setValue:names[1] forKey:AZFriendsSurnameKey];
        [fbUser setValue:names[2] forKey:AZFriendsFatherNameKey];
        [fbUser setValue:imageModel forKey:AZFriendsPictureKey];
        [fbUsers addObject:fbUser];
    }
    
    AZFBUsersModel *usersModel = [AZFBUsersModel arrayModelWithArray:fbUsers];
    self.controller.friends = usersModel;
    self.controller.friends.state = AZModelDidLoad;
}

- (NSString *)token {
    AZFBUserModel *user = (AZFBUserModel *)self.model;
    
    return user.token;
}

@end
