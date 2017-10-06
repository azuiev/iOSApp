//
//  AZGetContext.h
//  iOSApp
//
//  Created by Aleksey Zuiev on 01/10/2017.
//  Copyright © 2017 Aleksey Zuiev. All rights reserved.
//

#import "AZContext.h"

@interface AZGetContext : AZContext
@property (nonatomic, strong) NSString      *graphPath;
@property (nonatomic, strong) NSString      *token;
@property (nonatomic, strong) NSDictionary  *parameters;

+ (instancetype)contextWithModel:(AZModel *)model completionState:(AZModelState)state;

- (instancetype)initWithModel:(AZModel *)model completionState:(AZModelState)state;

//method for children purposes. Do not call this method directly
- (void)fillModelWithResponse:(id)response;

@end
