//
//  AZFBFriendsContext.m
//  iOSApp
//
//  Created by Aleksey Zuiev on 13/09/2017.
//  Copyright © 2017 Aleksey Zuiev. All rights reserved.
//

#import "AZFBFriendsContext.h"

#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import <FBSDKLoginKit/FBSDKLoginKit.h>
#import <FBSDKShareKit/FBSDKShareKit.h>

#import "AZFBUserModel.h"

#import "AZRandomNumber.h"

static NSString *AZFriendsGraphPath            = @"/me/friends";
static NSString *AZFriendsParametersKey        = @"fields";
static NSString *AZFriendsParametersValue      = @"id,first_name,last_name,picture{url}";
static NSString *AZFriendsDataKey              = @"data";
static NSString *AZFriendsIDKey                = @"id";
static NSString *AZFriendsTotalCountKey        = @"summary.total_count";
static NSString *AZUserSmallPictureURLKey      = @"picture.data.url";
static NSString *AZUserSmallPictureKey         = @"smallUserPicture";

@implementation AZFBFriendsContext

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

- (void)finishLoadingWithResponse:(id)result {
    NSNumber *count = [result valueForKeyPath:AZFriendsTotalCountKey];
    
    NSMutableArray *fbUsers = [NSMutableArray arrayWithCapacity:[count integerValue]];
    NSDictionary *users = [result valueForKey:AZFriendsDataKey];
    for (NSDictionary *user in users) {
        NSString *userID = [user valueForKey:AZFriendsIDKey];
        NSURL *imageURL = [NSURL URLWithString:[user valueForKeyPath:AZUserSmallPictureURLKey]];
        AZImageModel *imageModel = [AZImageModel imageModelWithURL:imageURL];
       
        
        AZFBUserModel *fbUser = [AZFBUserModel userWithID:userID];
        [self fillModel:fbUser withResponse:user];

        [fbUser setValue:imageModel forKey:AZUserSmallPictureKey];
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
