//
//  AZContext.m
//  iOSApp
//
//  Created by Aleksey Zuiev on 01/09/2017.
//  Copyright © 2017 Aleksey Zuiev. All rights reserved.
//

#import "AZContext.h"

@interface AZContext ()
@property (nonatomic, strong) AZModel   *model;

@end

@implementation AZContext

#pragma mark -
#pragma mark Initialization and Deallocation

+ (instancetype)contextWithModel:(AZModel *)model {
    return [[self alloc] initWithModel:model];
}

- (void)dealloc {
    self.model = nil;
}

- (instancetype)initWithModel:(AZModel *)model {
    self = [super init];
    if (self) {
        self.model = model;
    }
    
    return self;
}

- (void)execute {
    [self executeWithCompletionHandler:^ (AZModelState state) {
        self.model.state = state;
    }];
}

- (void)executeWithCompletionHandler:(void(^)(AZModelState state))completionHandler {
    
}

- (void)cancel {
    
}

@end
