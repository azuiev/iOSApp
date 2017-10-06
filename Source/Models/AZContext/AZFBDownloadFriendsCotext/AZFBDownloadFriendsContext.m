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

- (instancetype)initWithModel:(AZModel *)model completionState:(AZModelState)state {
    self = [super initWithModel:model completionState:state];
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
    
    AZFBUsersModel *fbUsersModel = (AZFBUsersModel *)self.model;
    [fbUsersModel addObjects:fbUsers];
}

- (NSString *)token {
    AZFBUserModel *user = (AZFBUserModel *)self.user;
    
    return user.token;
}

@end
