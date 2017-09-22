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

NSString *appKey = @"240815836441068|KYOIvMEMaTixlYL4SL4v09Hqoxc";

@interface AZFBDownloadFriendsContext ()
@property (nonatomic, strong) AZFBFriendsViewController   *controller;

@end

@implementation AZFBDownloadFriendsContext

#pragma mark -
#pragma mark Class methods

+ (instancetype)contextWithViewController:(AZFBFriendsViewController *)controller {
    return [[self alloc] initWithController:controller];
}

#pragma mark -
#pragma mark Initialization and Deallocation

- (instancetype)initWithController:(AZFBFriendsViewController *)controller {
    self = [super init];
    if (self) {
        self.controller = controller;
    }
    
    return self;
}

- (void)execute {
    FBSDKGraphRequest *request = [[FBSDKGraphRequest alloc]
                                  //initWithGraphPath:@"me/taggable_friends"
                                  //initWithGraphPath:@"me/friends"
                                  initWithGraphPath:@"/240815836441068/accounts/test-users?fields=id,access_token"
                                  parameters:nil
                                  tokenString:appKey
                                  version:nil
                                  HTTPMethod:@"GET"];
    
    [request startWithCompletionHandler:^(FBSDKGraphRequestConnection *connection,
                                          id result,
                                          NSError *error)
     {
         NSArray *friends = [result objectForKey:@"data"];
         
         __block NSMutableArray *fbUsers = [NSMutableArray arrayWithCapacity:friends.count];
         
         NSString *userIDs = [NSString new];
         
         for (NSDictionary *friend in friends) {
             NSString *userID = [friend valueForKey:@"id"];
             userIDs = [[userIDs stringByAppendingString:userID] stringByAppendingString:@","];
             AZFBUserModel *userModel = [AZFBUserModel userWithID:userID accessToken:[friend valueForKey:@"access_token"]];
             [fbUsers addObject:userModel];
         }
         
         userIDs = [userIDs substringToIndex:userIDs.length-(userIDs.length>0)];
         NSString *request = [NSString stringWithFormat:@"%@%@%@",@"?ids=",userIDs,@"&fields=name,picture"];
         
         FBSDKGraphRequest *imageURLRequest = [[FBSDKGraphRequest alloc]
                                               initWithGraphPath:request
                                               parameters:nil
                                               tokenString:appKey
                                               version:nil
                                               HTTPMethod:@"GET"];
         
         [imageURLRequest startWithCompletionHandler:^(FBSDKGraphRequestConnection *connection,
                                                       id result,
                                                       NSError *error)
          {
              for (AZFBUserModel *fbUser in fbUsers) {
                  NSDictionary *user = [result valueForKey:fbUser.userID];
                  NSURL *imageURL = [NSURL URLWithString:[[user valueForKey:@"data"] valueForKey:@"url"]];
                  AZImageModel *imageModel = [AZImageModel imageModelWithURL:imageURL];
                  
                  [fbUser setValue:[user valueForKey:@"name"] forKey:@"name"];
              }
              
              AZFBUsersModel *usersModel = [AZFBUsersModel arrayModelWithArray:fbUsers];
              self.controller.friends = usersModel;
              self.controller.friends.state = AZModelDidLoad;
          }];
     }];
}

@end
