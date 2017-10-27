//
//  AZFBUserDetailsContext.m
//  iOSApp
//
//  Created by Aleksey Zuiev on 18/09/2017.
//  Copyright © 2017 Aleksey Zuiev. All rights reserved.
//

#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import <FBSDKLoginKit/FBSDKLoginKit.h>
#import <FBSDKShareKit/FBSDKShareKit.h>

#import "AZFBUserDetailsContext.h"
#import "AZFBUserModel.h"

#import "AZMacros.h"

static NSString *AZUserParametersKey       = @"fields";
static NSString *AZUserParametersValue     = @"first_name,last_name,middle_name,birthday,gender,picture.height(9999){url}";

@implementation AZFBUserDetailsContext

@dynamic token;
@dynamic graphPath;
@dynamic user;

#pragma mark -
#pragma mark Initialization and Deallocation

- (instancetype)initWithModel:(AZModel *)model {
    self = [super initWithModel:model];
    if (self) {
        self.parameters = @{AZUserParametersKey:AZUserParametersValue};
    }
    
    return self;
}

#pragma mark -
#pragma mark Accessors

- (AZFBUserModel *)user {
    return (AZFBUserModel *)self.model;
}

#pragma mark -
#pragma mark Overrided methods

- (void)finishLoadingWithResponse:(id)result {
    [self fillModel:self.user withResponse:result];
}

- (NSString *)graphPath {
    return self.user.userID;
}

@end
