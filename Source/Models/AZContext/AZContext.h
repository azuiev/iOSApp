//
//  AZContext.h
//  iOSApp
//
//  Created by Aleksey Zuiev on 01/09/2017.
//  Copyright © 2017 Aleksey Zuiev. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "AZModel.h"
#import "AZFBCurrentUser.h"

@interface AZContext : AZModel
@property (nonatomic, readonly) AZModel         *model;
@property (nonatomic, readonly) NSString        *token;
@property (nonatomic, strong)   AZFBCurrentUser *currentUser;

+ (instancetype)contextWithModel:(AZModel *)model;

- (instancetype)initWithModel:(AZModel *)model;
- (void)execute;

//method forchildren purposes
- (void)executeWithCompletionHandler:(void(^)(AZModelState state))completionHandler;
- (void)cancel;

@end
