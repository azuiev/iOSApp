//
//  AZFBGetContext.h
//  iOSApp
//
//  Created by Aleksey Zuiev on 01/10/2017.
//  Copyright © 2017 Aleksey Zuiev. All rights reserved.
//

#import "AZContext.h"

@class AZFBUserModel;

@interface AZFBGetContext : AZContext
@property (nonatomic, strong)   NSString        *graphPath;
@property (nonatomic, strong)   NSDictionary    *parameters;
@property (nonatomic, readonly) AZFBUserModel   *user;

//method for children purposes. Do not call this method directly
- (void)finishLoadingWithResponse:(id)result;
- (void)fillModel:(AZFBUserModel *)model withResponse:(id)result;

@end
