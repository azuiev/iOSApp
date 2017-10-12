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

static NSString *AZUserParametersKey       = @"fields";
static NSString *AZUserParametersValue     = @"name,email,birthday,gender,picture.height(9999){url}";
static NSString *AZUserGenderKey           = @"gender";
static NSString *AZUserBirthdayKey         = @"birthday";
static NSString *AZUserEmailKey            = @"email";
static NSString *AZUserLargePictureURLKey  = @"picture.data.url";
static NSString *AZUserLargePictureKey     = @"largeUserPicture";

@implementation AZFBDownloadUserDetailsContext

@dynamic token;
@dynamic graphPath;

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
#pragma mark Overrided methods

- (void)fillModel:(AZFBUserModel *)user withResponse:(id)result {
    [super fillModel:user withResponse:result];
    
    NSURL *imageURL = [NSURL URLWithString:[result valueForKeyPath:AZUserLargePictureURLKey]];
    AZImageModel *imageModel = [AZImageModel imageModelWithURL:imageURL];
    [user setValue:imageModel forKey:AZUserLargePictureKey];
    
    [user setValue:[result valueForKey:AZUserEmailKey] forKey:AZUserEmailKey];
    [user setValue:[result valueForKey:AZUserGenderKey] forKey:AZUserGenderKey];
    [user setValue:[result valueForKey:AZUserBirthdayKey] forKey:AZUserBirthdayKey];
}

- (void)finishLoadingWithResponse:(id)result {
    AZFBUserModel *user = (AZFBUserModel *)self.model;
    
    [self fillModel:user withResponse:result];
}

- (NSString *)graphPath {
    return [(AZFBUserModel *)self.model userID];
}

- (NSString *)token {
    AZFBUserModel *user = (AZFBUserModel *)self.model;
    
    return user.token;
}

@end
