//
//  AZFBUserModel.m
//  iOSApp
//
//  Created by Aleksey Zuiev on 11/09/2017.
//  Copyright © 2017 Aleksey Zuiev. All rights reserved.
//

#import <FBSDKLoginKit/FBSDKLoginKit.h>
#import <FBSDKCoreKit/FBSDKCoreKit.h>

#import "AZFBUserModel.h"
#import "AZFBUserModelCashe.h"

@interface AZFBUserModel ()
@property (nonatomic, strong) NSString        *userID;
@property (nonatomic, strong) NSString        *token;
@property (nonatomic, strong) NSString        *email;
@property (nonatomic, strong) NSString        *middleName;
@property (nonatomic, strong) NSString        *gender;
@property (nonatomic, strong) NSDate          *birthday;

@end

@implementation AZFBUserModel

#pragma mark -
#pragma mark Class methods

+ (instancetype)userWithID:(NSString *)userID {
    return [self userWithID:userID accessToken:nil];
}

+ (instancetype)userWithID:(NSString *)userID accessToken:(NSString *)accessToken {
    AZFBUserModelCashe *cache = [AZFBUserModelCashe sharedCache];
    AZFBUserModel *model = [cache objectForKey:userID];
    
    if (!model) {
        model = [[self alloc] initWithID:userID accessToken:accessToken];
        
        [cache setObject:model forKey:userID];
    }
    
    return model;
}

#pragma mark -
#pragma mark Initialization

- (instancetype)initWithID:(NSString *)userID accessToken:(NSString *)accessToken {
   
    self = [super init];
    if (self) {
        self.userID = userID;
        self.token = accessToken;
    }
    
    return self;
}

#pragma mark -
#pragma mark Accessors

- (NSString *)fullNameWithMiddleName {
    return [NSString stringWithFormat:@"%@ %@ %@", self.name, self.middleName, self.surname];
}

#pragma mark -
#pragma mark Public methods

- (BOOL)isLogged {
    FBSDKAccessToken *accessToken = [FBSDKAccessToken currentAccessToken];
    
    return ([self.userID isEqualToString:accessToken.userID] && [self.token isEqualToString:accessToken.tokenString]);
}

- (void)clearToken {
    self.token = nil;
}

@end
