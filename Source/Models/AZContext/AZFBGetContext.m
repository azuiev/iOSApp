//
//  AZFBGetContext.m
//  iOSApp
//
//  Created by Aleksey Zuiev on 01/10/2017.
//  Copyright © 2017 Aleksey Zuiev. All rights reserved.
//

#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import <FBSDKLoginKit/FBSDKLoginKit.h>
#import <FBSDKShareKit/FBSDKShareKit.h>

#import "AZFBGetContext.h"

#import "AZFBUserModel.h"

#import "AZMacros.h"

#import "NSString+AZExtension.h"

static NSString *AZRequestMethod           = @"GET";
static NSString *AZUserNameKey             = @"name";
static NSString *AZUserSurnameKey          = @"surname";
static NSString *AZUserFatherNameKey       = @"fatherName";



@interface AZFBGetContext ()
@property (nonatomic, assign) AZModelState modelState;

- (void)finishLoadingWithResponse:(id)result;

@end

@implementation AZFBGetContext

#pragma mark -
#pragma mark Public methods

- (void)executeWithCompletionHandler:(void (^)(AZModelState))completionHandler {
    AZWeakify(self);
    FBSDKGraphRequest *request = [[FBSDKGraphRequest alloc]
                                  initWithGraphPath:self.graphPath
                                  parameters:self.parameters
                                  tokenString:self.token
                                  version:nil
                                  HTTPMethod:AZRequestMethod];
    
    [request startWithCompletionHandler:^(FBSDKGraphRequestConnection *connection,
                                          id result,
                                          NSError *error)
     {
         if (error) {
             completionHandler(AZModelDidFailLoad);
         } else {
             AZStrongify(self);
             
             [self finishLoadingWithResponse:result];
             
             completionHandler(AZModelDidLoad);
         }
     }];
}

#pragma mark -
#pragma mark Public methods

- (void)finishLoadingWithResponse:(id)result {
    
}

- (void)fillModel:(AZFBUserModel *)model withResponse:(id)result {
    NSString *name = [result valueForKey:AZUserNameKey];
    NSArray *names = [[NSString removeMultipleSpaces:name] componentsSeparatedByString:@" "];

    [model setValue:names[0] forKey:AZUserNameKey];
    [model setValue:names[1] forKey:AZUserSurnameKey];
    [model setValue:names[2] forKey:AZUserFatherNameKey];
}

@end
