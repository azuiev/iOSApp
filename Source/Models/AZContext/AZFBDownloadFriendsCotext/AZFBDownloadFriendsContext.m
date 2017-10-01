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

NSString *AZFriendsGraphPath       = @"/me/friends";
NSString *AZFriendsParametersKey   = @"fileds";
NSString *AZFriendsParametersValue = @"id,name,picture{url}";

@implementation AZFBDownloadFriendsContext

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

- (void)parseResult:(id)result {
    NSNumber *count = [result valueForKeyPath:@"summary.total_count"];
    
    NSMutableArray *fbUsers = [NSMutableArray arrayWithCapacity:[count integerValue]];
    NSDictionary *users = [result valueForKey:@"data"];
    for (NSDictionary *user in users) {
        NSString *userID = [user valueForKey:@"id"];
        NSURL *imageURL = [NSURL URLWithString:[user valueForKeyPath:@"picture.data.url"]];
        AZImageModel *imageModel = [AZImageModel imageModelWithURL:imageURL];
        NSArray *names = [[user valueForKey:@"name"] componentsSeparatedByString:@" "];
        
        AZFBUserModel *fbUser = [AZFBUserModel userWithID:userID];
        [fbUser setValue:names[0] forKey:@"name"];
        [fbUser setValue:names[1] forKey:@"surname"];
        [fbUser setValue:names[2] forKey:@"fatherName"];
        [fbUser setValue:imageModel forKey:@"smallUserPicture"];
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
