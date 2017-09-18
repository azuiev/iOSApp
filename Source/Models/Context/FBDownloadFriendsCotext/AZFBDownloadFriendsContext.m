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
                                  initWithGraphPath:@"me/taggable_friends"
                                  parameters:nil
                                  HTTPMethod:@"GET"];
    
    [request startWithCompletionHandler:^(FBSDKGraphRequestConnection *connection,
                                          id result,
                                          NSError *error)
     {
         NSArray *friends = [result objectForKey:@"data"];
         
         NSMutableArray *fbFriends = [NSMutableArray arrayWithCapacity:friends.count];
         
         for (NSDictionary *friend in friends) {
             NSDictionary *picture = [friend valueForKey:@"picture"];
             NSString *fullName = [friend valueForKey:@"name"];
             //NSString *userId = [friend valueForKey:@"id"];
             
             NSDictionary *data = [picture valueForKey:@"data"];
             NSURL *url = [NSURL URLWithString:[data valueForKey:@"url"]];
             
             [fbFriends addObject:[AZFBUserModel userWithFullName:fullName url:url]];
         }
         
         AZFBUsersModel *usersModel = [AZFBUsersModel arrayModelWithArray:fbFriends];
         self.controller.friends = usersModel;
         self.controller.friends.state = AZModelDidLoad;
     }];
}

@end
