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

NSString *AZUserParametersKey       = @"fields";
NSString *AZUserParametersValue     = @"name,email,birthday,gender,picture.height(9999){url}";
NSString *AZUserNameKey             = @"name";
NSString *AZUserSurnameKey          = @"surname";
NSString *AZUserFatherNameKey       = @"fatherName";
NSString *AZUserGenderKey           = @"gender";
NSString *AZUserBirthdayKey         = @"birthday";
NSString *AZUserEmailKey            = @"email";
NSString *AZUserPictureURLKey       = @"picture.data.url";
NSString *AZUserPictureKey          = @"largeUserPicture";

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

- (void)fillModelWithResponse:(id)result {
    AZFBUserModel *user = (AZFBUserModel *)self.model;
    NSURL *imageURL = [NSURL URLWithString:[result valueForKeyPath:AZUserPictureURLKey]];
    AZImageModel *imageModel = [AZImageModel imageModelWithURL:imageURL];
    NSString *name = [result valueForKey:AZUserNameKey];
    NSArray *names = [[NSString removeMultipleSpaces:name] componentsSeparatedByString:@" "];
    
    [user setValue:[result valueForKey:AZUserEmailKey] forKey:AZUserEmailKey];
    [user setValue:[result valueForKey:AZUserGenderKey] forKey:AZUserGenderKey];
    [user setValue:[result valueForKey:AZUserBirthdayKey] forKey:AZUserBirthdayKey];
    [user setValue:imageModel forKey:AZUserPictureKey];
    [user setValue:names[0] forKey:AZUserNameKey];
    [user setValue:names[1] forKey:AZUserSurnameKey];
    [user setValue:names[2] forKey:AZUserFatherNameKey];
    
    self.model.state = AZModelDidLoad;
}

- (NSString *)graphPath {
    return [(AZFBUserModel *)self.model userID];
}

- (NSString *)token {
    AZFBUserModel *user = (AZFBUserModel *)self.model;
    
    return user.token;
}

@end
