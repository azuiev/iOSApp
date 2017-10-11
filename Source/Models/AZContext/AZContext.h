//
//  AZContext.h
//  iOSApp
//
//  Created by Aleksey Zuiev on 01/09/2017.
//  Copyright © 2017 Aleksey Zuiev. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "AZModel.h"

@interface AZContext : AZModel
@property (nonatomic, readonly) AZModel    *model;

+ (instancetype)contextWithModel:(AZModel *)model;

- (instancetype)initWithModel:(AZModel *)model;
- (void)execute;

//method forchildren purposes
- (void)executeWithCompletionHandler:(void(^)())completionHandler;
- (void)cancel;

@end
