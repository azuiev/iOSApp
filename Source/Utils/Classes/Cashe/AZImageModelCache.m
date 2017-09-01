//
//  AZImageModelCache.m
//  iOSApp
//
//  Created by Aleksey Zuiev on 18/08/2017.
//  Copyright © 2017 Aleksey Zuiev. All rights reserved.
//

#import "AZImageModelCache.h"

@interface AZImageModelCache ()
@property (nonatomic, strong) NSMapTable *cache;
@end

@implementation AZImageModelCache

#pragma mark -
#pragma mark Class Methods

+ (instancetype)sharedCache {
    static dispatch_once_t onceToken;
    static id cache = nil;
    dispatch_once(&onceToken, ^{
        cache = [self new];
    });
    
    return cache;
}

#pragma mark -
#pragma mark Initialization and Deallocation

- (void)dealloc {
    self.cache = nil;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        self.cache = [NSMapTable strongToWeakObjectsMapTable];
    }
    
    return self;
}

#pragma mark -
#pragma mark Public Methods

- (void)setObject:(AZImageModel *)object forKey:(NSURL *)key {
    @synchronized (self) {
        [self.cache setObject:object forKey:key];
    }
}

- (void)removeObjectForKey:(NSURL *)key {
    @synchronized (self) {
        [self.cache removeObjectForKey:key];
    }
}

- (id)objectForKey:(NSURL *)key {
    return [self.cache objectForKey:key];
}

@end
