//
//  AZCashe.m
//  iOSApp
//
//  Created by Aleksey Zuiev on 18/08/2017.
//  Copyright © 2017 Aleksey Zuiev. All rights reserved.
//

#import "AZCashe.h"

@interface AZCashe ()
@property (nonatomic, strong) NSMutableDictionary *cashe;
@end

@implementation AZCashe

#pragma mark -
#pragma mark Class Methods

+ (instancetype)sharedCashe {
    static dispatch_once_t onceToken;
    static id cashe = nil;
    dispatch_once(&onceToken, ^{
        cashe = [self new];
    });
    
    return cashe;
}

#pragma mark -
#pragma mark Initialization and Deallocation

- (void)dealloc {
    self.cashe = nil;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        self.cashe = [NSMutableDictionary dictionary];
    }
    
    return self;
}

#pragma mark -
#pragma mark Public Methods

- (void)addObject:(id)object forKey:(id)key {
    
}

- (void)removeKey:(id)key {
    
}

- (BOOL)isCashed:(id)key {
    return NO;
}

- (id)objectForKey:(id)key {
    return nil;
}

- (NSArray *)getAllKeys {
    return nil;
}

@end
