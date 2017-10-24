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
@property (nonatomic, readonly) AZFBUsersModel      *friends;
@property (nonatomic, strong)   AZFBUserModel       *privateUser;

@end

@implementation AZFBFriendsContext

@dynamic token;
@dynamic graphPath;
@dynamic friends;

#pragma mark -
#pragma mark Class Methods

+ (instancetype)contextWithModel:(AZModel *)model user:(AZFBUserModel *)user {
    return [[self alloc] initWithModel:model user:user];
}

#pragma mark -
#pragma mark Initialization and Deallocation

- (void)dealloc {
    self.user = nil;
}

- (instancetype)initWithModel:(AZModel *)model user:(AZFBUserModel *)user {
    self = [super initWithModel:model];
    if (self) {
        self.privateUser = user;
        self.parameters = @{AZFriendsParametersKey:AZFriendsParametersValue};
    }
    
    return self;
}

#pragma mark -
#pragma mark Accessors

- (AZFBUsersModel *)friends {
    return (AZFBUsersModel *)self.model;
}

- (AZFBUserModel *)user {
    return self.privateUser;
}

- (void)setUser:(AZFBUserModel *)user {
    self.privateUser = user;
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
