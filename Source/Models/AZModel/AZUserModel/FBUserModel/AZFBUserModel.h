//
//  AZFBUserModel.h
//  iOSApp
//
//  Created by Aleksey Zuiev on 11/09/2017.
//  Copyright © 2017 Aleksey Zuiev. All rights reserved.
//

#import "AZUserModel.h"

@interface AZFBUserModel : AZUserModel
@property (nonatomic, readonly) NSString        *userID;
@property (nonatomic, readonly) NSString        *token;
@property (nonatomic, readonly) NSString        *email;
@property (nonatomic, readonly) NSString        *middleName;
@property (nonatomic, readonly) NSString        *gender;
@property (nonatomic, readonly) NSDate          *birthday;

@property (nonatomic, readonly) NSString        *fullNameWithMiddleName;

+ (instancetype)userWithID:(NSString *)userID accessToken:(NSString *)accessToken;
+ (instancetype)userWithID:(NSString *)userID;

- (BOOL)isLogged;
- (void)clearToken;

@end
