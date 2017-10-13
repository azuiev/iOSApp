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

static NSString *AZRequestMethod            = @"GET";
static NSString *AZUserFirstNameKey         = @"first_name";
static NSString *AZUserLastNameKey          = @"last_name";
static NSString *AZUserName                 = @"name";
static NSString *AZUserSurname              = @"surname";

@interface AZFBGetContext ()
@property (nonatomic, assign) AZModelState  modelState;
@property (nonatomic, readonly) NSString    *plistName;

- (void)finishLoadingWithResponse:(id)result;
- (void)saveResponse;
- (id)loadSavedResponse;

@end

@implementation AZFBGetContext

@dynamic plistName;

#pragma mark -
#pragma mark Public methods

- (void)finishLoadingWithResponse:(id)result {
    
}

- (void)fillModel:(AZFBUserModel *)model withResponse:(id)result {
    [model setValue:[result valueForKey:AZUserFirstNameKey] forKey:AZUserName];
    [model setValue:[result valueForKey:AZUserLastNameKey] forKey:AZUserSurname];
}

#pragma mark -
#pragma mark Override methods

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
         AZStrongify(self);
         if (error) {
             id loadResult = [self loadSavedResponse];
             if (loadResult) {
                 NSLog(@"Loading from cache");
                 [self finishLoadingWithResponse:loadResult];
                 
                 completionHandler(AZModelDidLoad);
             } else {
                 completionHandler(AZModelDidFailLoad);
             }
         } else {
             [self saveResponse:result];
             [self finishLoadingWithResponse:result];
             
             completionHandler(AZModelDidLoad);
         }
     }];
}

#pragma mark -
#pragma mark Private methods

- (void)saveResponse:(id)result {
    [NSKeyedArchiver archiveRootObject:result toFile:self.plistName];
}

- (id)loadSavedResponse {
    return [NSKeyedUnarchiver unarchiveObjectWithFile:self.plistName];
}

- (NSString *)plistName {
    NSArray *paths = NSSearchPathForDirectoriesInDomains (NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *result = [paths firstObject];
    
    return [NSString stringWithFormat:@"%@/%@.plist", result, [NSString removeIllegalSymbols:self.graphPath]];
}

@end
