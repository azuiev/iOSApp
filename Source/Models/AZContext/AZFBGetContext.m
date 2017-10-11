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
#import "AZMacros.h"

NSString *AZRequestMethod = @"GET";

@interface AZFBGetContext ()
@property (nonatomic, assign) AZModelState modelState;

- (void)finishLoadingWithResponse:(id)result;

@end

@implementation AZFBGetContext

#pragma mark -
#pragma mark Public methods

- (void)execute {
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
         [self finishLoadingWithResponse:result];
     }];
}

- (void)fillModelWithResponse:(id)result {
    
}

#pragma mark -
#pragma mark Private methods

- (void)finishLoadingWithResponse:(id)result {
    [self fillModelWithResponse:result];
    
    self.model.state = AZModelDidLoad;
}


- (void)executeWithSettingState {
    [self executeWithCompletionHandler:^ {
        self.model.state = self.model ? AZModelDidLoad : AZModelDidFailLoad;
    }];
}
@end
