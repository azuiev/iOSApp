//
//  AZFBUserModel.m
//  iOSApp
//
//  Created by Aleksey Zuiev on 11/09/2017.
//  Copyright © 2017 Aleksey Zuiev. All rights reserved.
//

#import "AZFBUserModel.h"

@interface AZFBUserModel ()
@property (nonatomic, strong) NSString        *userID;
@property (nonatomic, strong) NSString        *token;
@property (nonatomic, strong) NSString        *email;
@property (nonatomic, strong) NSString        *fatherName;
@property (nonatomic, strong) NSString        *gender;
@property (nonatomic, strong) NSDate          *birthday;

@property (nonatomic, strong) AZImageModel    *largeUserPicture;

@end

@implementation AZFBUserModel

#pragma mark -
#pragma mark Class methods

+ (instancetype)userWithID:(NSString *)userID accessToken:(NSString *)accessToken {
    return [[self alloc] initWithID:userID accessToken:accessToken];
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

- (NSString *)fullName {
    return [NSString stringWithFormat:@"%@ %@ %@", self.name, self.surname, self.fatherName];
}

@end
