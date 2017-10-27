//
//  AZFBUserModel.m
//  iOSApp
//
//  Created by Aleksey Zuiev on 11/09/2017.
//  Copyright © 2017 Aleksey Zuiev. All rights reserved.
//

#import "AZFBUserModel.h"
#import "AZFBUserModelCashe.h"

@interface AZFBUserModel ()
@property (nonatomic, strong) NSString        *userID;
@property (nonatomic, strong) NSString        *middleName;
@property (nonatomic, strong) NSString        *gender;
@property (nonatomic, strong) NSDate          *birthday;

@end

@implementation AZFBUserModel

#pragma mark -
#pragma mark Class methods

+ (instancetype)userWithID:(NSString *)userID {
    AZFBUserModelCashe *cache = [AZFBUserModelCashe sharedCache];
    AZFBUserModel *model = [cache objectForKey:userID];
    
    if (!model) {
        model = [[self alloc] initWithID:userID];
        
        [cache setObject:model forKey:userID];
    }
    
    return model;
}

#pragma mark -
#pragma mark Initialization and deallocation

- (instancetype)initWithID:(NSString *)userID {
    self = [super init];
    if (self) {
        self.userID = userID;
    }
    
    return self;
}

#pragma mark -
#pragma mark Accessors

- (NSString *)fullNameWithMiddleName {
    return [NSString stringWithFormat:@"%@ %@ %@", self.name, self.middleName, self.surname];
}


@end
