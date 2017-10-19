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
#import "AZFBUserParser.h"

#import "AZRandomNumber.h"

static NSString *AZFriendsParametersKey        = @"fields";
static NSString *AZFriendsParametersValue      = @"id,first_name,last_name,picture{url}";
static NSString *AZFriendsDataKey              = @"data";
static NSString *AZFriendsTotalCountKey        = @"summary.total_count";
static NSString *AZFriendsExtensionString      = @"/friends/";

@interface AZFBFriendsContext ()
@property (nonatomic, strong) AZFBUserModel     *privateUser;

@end

@implementation AZFBFriendsContext

@dynamic token;
@dynamic graphPath;

#pragma mark -
#pragma mark Initialization and Deallocation

- (void)dealloc {
    self.privateUser = nil;
}

- (instancetype)initWithModel:(AZModel *)model {
    self = [super initWithModel:model];
    if (self) {
        self.parameters = @{AZFriendsParametersKey:AZFriendsParametersValue};
    }
    
    return self;
}

#pragma mark -
#pragma mark Accessors

- (AZFBUserModel *)user {
    return self.privateUser;
}

- (void)setUser:(AZFBUserModel *)user {
    self.privateUser = user;
}

- (AZFBUsersModel *)friends {
    return (AZFBUsersModel *)self.model;
}

#pragma mark -
#pragma mark Overrided methods

- (void)finishLoadingWithResponse:(id)result {
    NSNumber *count = [result valueForKeyPath:AZFriendsTotalCountKey];
    
    NSMutableArray *fbUsers = [NSMutableArray arrayWithCapacity:[count integerValue]];
    NSDictionary *response = [result valueForKey:AZFriendsDataKey];
    for (NSDictionary *userResponse in response) {
        [fbUsers addObject:[AZFBUserParser userWithObject:userResponse]];
    }
    
    [self.friends addObjects:fbUsers];
}

- (NSString *)graphPath {
    return [self.user.userID stringByAppendingString:AZFriendsExtensionString];
}

- (NSString *)token {
    return self.user.token;
}

@end
