//
//  AZContext.m
//  iOSApp
//
//  Created by Aleksey Zuiev on 01/09/2017.
//  Copyright © 2017 Aleksey Zuiev. All rights reserved.
//

#import "AZContext.h"

@interface AZContext ()
@property (nonatomic, strong) NSObject *model;
@end

@implementation AZContext

#pragma mark -
#pragma mark Initialization and Deallocation

+ (instancetype)contextWithModel:(NSObject *)model {
    return [[self alloc]initWithModel:model];
}

- (void)dealloc {
    self.model = nil;
}

- (instancetype)initWithModel:(NSObject *)model {
    self = [super init];
    if (self) {
        self.model = model;
        [self execute];
    }
    
    return self;
}

- (void)execute {

}

- (void)cancel {
    
}

@end
