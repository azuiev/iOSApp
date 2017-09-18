//
//  AZDownloadFriendDetailsContext.m
//  iOSApp
//
//  Created by Aleksey Zuiev on 18/09/2017.
//  Copyright © 2017 Aleksey Zuiev. All rights reserved.
//

#import "AZDownloadFriendDetailsContext.h"

#import "AZFBUserModel.h"

#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import <FBSDKLoginKit/FBSDKLoginKit.h>
#import <FBSDKShareKit/FBSDKShareKit.h>

@implementation AZDownloadFriendDetailsContext

- (void)execute {
    AZFBUserModel *user = (AZFBUserModel *)self.model;
    FBSDKGraphRequest *request = [[FBSDKGraphRequest alloc]
                                  initWithGraphPath:user.userID
                                  parameters:nil
                                  HTTPMethod:@"GET"];
    
    [request startWithCompletionHandler:^(FBSDKGraphRequestConnection *connection,
                                          id result,
                                          NSError *error)
     {
         NSArray *friends = [result objectForKey:@"data"];
        
     }];
}
@end
