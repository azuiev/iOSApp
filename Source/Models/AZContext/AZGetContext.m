//
//  AZGetContext.m
//  iOSApp
//
//  Created by Aleksey Zuiev on 01/10/2017.
//  Copyright © 2017 Aleksey Zuiev. All rights reserved.
//

#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import <FBSDKLoginKit/FBSDKLoginKit.h>
#import <FBSDKShareKit/FBSDKShareKit.h>

#import "AZGetContext.h"
#import "AZMacros.h"

NSString *AZRequestMethod = @"GET";

@interface AZGetContext ()
@property (nonatomic, assign) AZModelState modelState;

- (void)finishLoadingWithResponse:(id)result;

@end

@implementation AZGetContext

#pragma mark -
#pragma mark Class Methods

+ (instancetype)contextWithModel:(AZModel *)model completionState:(AZModelState)state {
    return [[self alloc ] initWithModel:model completionState:state];
}

#pragma mark -
#pragma mark Initialization and deallocation

- (instancetype)initWithModel:(AZModel *)model completionState:(AZModelState)state {
    self = [super initWithModel:model];
    if (self) {
        self.modelState = state;
    }
    
    return self;
}

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
    
    self.model.state = self.modelState;
}

@end
