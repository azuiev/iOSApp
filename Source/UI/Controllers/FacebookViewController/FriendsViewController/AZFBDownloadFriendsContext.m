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
                                  initWithGraphPath:@"/240815836441068/accounts/test-users?fields=id"
                                  parameters:nil
                                  tokenString:@"240815836441068|KYOIvMEMaTixlYL4SL4v09Hqoxc"
                                  version:nil
                                  HTTPMethod:@"GET"];

    [request startWithCompletionHandler:^(FBSDKGraphRequestConnection *connection,
                                          id result,
                                          NSError *error)
     {
         NSArray *friends = [result objectForKey:@"data"];
         
         NSMutableArray *fbFriends = [NSMutableArray arrayWithCapacity:friends.count];
         __block NSString *fullName = nil;
         __block NSURL *imageURL = nil;
         
         for (NSDictionary *friend in friends) {
             NSString *userID = [friend valueForKey:@"id"];
             
             FBSDKGraphRequest *nameRequest = [[FBSDKGraphRequest alloc]
                                               initWithGraphPath:userID
                                               parameters:nil
                                               tokenString:@"240815836441068|KYOIvMEMaTixlYL4SL4v09Hqoxc"
                                               version:nil
                                               HTTPMethod:@"GET"];
             
             [nameRequest startWithCompletionHandler:^(FBSDKGraphRequestConnection *connection,
                                                       id result,
                                                       NSError *error)
              {
                  fullName = [result valueForKey:@"name"];
              }];
             
             FBSDKGraphRequest *imageURLRequest = [[FBSDKGraphRequest alloc]
                                                   initWithGraphPath:[userID stringByAppendingString:@"/picture"]
                                                   parameters:nil
                                                   tokenString:@"240815836441068|KYOIvMEMaTixlYL4SL4v09Hqoxc"
                                                   version:nil
                                                   HTTPMethod:@"GET"];
             
             [imageURLRequest startWithCompletionHandler:^(FBSDKGraphRequestConnection *connection,
                                                           id result,
                                                           NSError *error)
              {
                  imageURL = [NSURL URLWithString:[[result valueForKey:@"data"] valueForKey:@"url"]];
              }];
             
             [fbFriends addObject:[AZFBUserModel userWithID:userID fullName:fullName url:imageURL]];
         }
         
         AZFBUsersModel *usersModel = [AZFBUsersModel arrayModelWithArray:fbFriends];
         self.controller.friends = usersModel;
         self.controller.friends.state = AZModelDidLoad;
     }];
}

@end
