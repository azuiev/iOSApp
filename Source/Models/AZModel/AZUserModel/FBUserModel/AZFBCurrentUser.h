//
//  AZFBCurrentUser.h
//  iOSApp
//
//  Created by Aleksey Zuiev on 27/10/2017.
//  Copyright © 2017 Aleksey Zuiev. All rights reserved.
//

#import "AZFBUserModel.h"

@interface AZFBCurrentUser : AZFBUserModel
@property (nonatomic, strong) NSString        *token;

+ (instancetype)userWithID:(NSString *)userID accessToken:(NSString *)accessToken;

- (instancetype)initWithID:(NSString *)userID accessToken:(NSString *)accessToken;

- (BOOL)isLogged;
- (void)clearToken;

@end
