//
//  AZFBDownloadFriendDetailsContext.m
//  iOSApp
//
//  Created by Aleksey Zuiev on 18/09/2017.
//  Copyright © 2017 Aleksey Zuiev. All rights reserved.
//

#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import <FBSDKLoginKit/FBSDKLoginKit.h>
#import <FBSDKShareKit/FBSDKShareKit.h>

#import "AZFBDownloadFriendDetailsContext.h"
#import "AZFBUserModel.h"

#import "AZMacros.h"

NSString *genderKey = @"gender";
NSString *birthdayKey = @"birthday";
NSString *emailKey = @"email";

NSUInteger AZMaxImageHight = 9999;

@implementation AZFBDownloadFriendDetailsContext

- (void)execute {
    AZFBUserModel *user = (AZFBUserModel *)self.model;
    AZWeakify(user);
    NSString *parameters = [NSString stringWithFormat:@"%@%lu%@",@"email,birthday,gender,picture.height(", (unsigned long)AZMaxImageHight, @"){url}"];
    FBSDKGraphRequest *request = [[FBSDKGraphRequest alloc]
                                  initWithGraphPath:user.userID
                                  parameters:@{@"fields":parameters}
                                  tokenString:user.token
                                  version:nil
                                  HTTPMethod:@"GET"];
    
    [request startWithCompletionHandler:^(FBSDKGraphRequestConnection *connection,
                                          id result,
                                          NSError *error)
    {
        AZStrongify(user);
        NSURL *imageURL = [NSURL URLWithString:[[[result valueForKey:@"picture"] valueForKey:@"data"] valueForKey:@"url"]];
        AZImageModel *imageModel = [AZImageModel imageModelWithURL:imageURL];
        
        [user setValue:[result valueForKey:emailKey] forKey:emailKey];
        [user setValue:[result valueForKey:genderKey] forKey:genderKey];
        [user setValue:[result valueForKey:birthdayKey] forKey:birthdayKey];
        [user setValue:imageModel forKey:@"largeUserPicture"];
        
        user.state = AZModelDidLoad;
    }];
}

@end
