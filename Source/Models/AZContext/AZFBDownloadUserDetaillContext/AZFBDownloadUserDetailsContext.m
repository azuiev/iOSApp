//
//  AZFBDownloadUserDetailsContext.m
//  iOSApp
//
//  Created by Aleksey Zuiev on 18/09/2017.
//  Copyright © 2017 Aleksey Zuiev. All rights reserved.
//

#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import <FBSDKLoginKit/FBSDKLoginKit.h>
#import <FBSDKShareKit/FBSDKShareKit.h>

#import "AZFBDownloadUserDetailsContext.h"
#import "AZFBUserModel.h"

#import "AZMacros.h"
#import "NSString+AZExtension.h"

NSString *genderKey = @"gender";
NSString *birthdayKey = @"birthday";
NSString *emailKey = @"email";

NSUInteger AZMaxImageHight = 9999;

NSString *AZParametersKey   = @"fileds";
NSString *AZParametersValue = @"name,email,birthday,gender,picture.height(9999){url}";

@implementation AZFBDownloadUserDetailsContext

- (void)execute {
    AZFBUserModel *user = (AZFBUserModel *)self.model;
    AZWeakify(user);
    NSString *parameters = [NSString stringWithFormat:@"%@%lu%@",@"name,email,birthday,gender,picture.height(", (unsigned long)AZMaxImageHight, @"){url}"];
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
         NSString *name = [result valueForKey:@"name"];
         NSArray *names = [[NSString removeMultipleSpaces:name] componentsSeparatedByString:@" "];
         
         [user setValue:[result valueForKey:emailKey] forKey:emailKey];
         [user setValue:[result valueForKey:genderKey] forKey:genderKey];
         [user setValue:[result valueForKey:birthdayKey] forKey:birthdayKey];
         [user setValue:imageModel forKey:@"largeUserPicture"];
         [user setValue:names[0] forKey:@"name"];
         [user setValue:names[1] forKey:@"surname"];
         [user setValue:names[2] forKey:@"fatherName"];
         
         user.state = AZModelDidLoad;
     }];
}

@end
