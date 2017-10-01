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

NSString *AZUserParametersKey   = @"fields";
NSString *AZUserParametersValue = @"name,email,birthday,gender,picture.height(9999){url}";

@implementation AZFBDownloadUserDetailsContext

#pragma mark -
#pragma mark Initialization and Deallocation

- (instancetype)initWithModel:(AZModel *)model {
    self = [super initWithModel:model];
    if (self) {
        self.graphPath  = [(AZFBUserModel *)self.model userID];
        self.parameters = @{AZUserParametersKey:AZUserParametersValue};
    }
    
    return self;
}

#pragma mark -
#pragma mark Overrided methods

- (void)parseResult:(id)result {
    AZFBUserModel *user = (AZFBUserModel *)self.model;
    NSURL *imageURL = [NSURL URLWithString:[result valueForKeyPath:@"picture.data.url"]];
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
    
    self.model.state = AZModelDidLoad;
}

- (NSString *)token {
    AZFBUserModel *user = (AZFBUserModel *)self.model;
    
    return user.token;
}

@end
