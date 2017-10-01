//
//  AZFBUserModelCashe.m
//  iOSApp
//
//  Created by Aleksey Zuiev on 29/09/2017.
//  Copyright © 2017 Aleksey Zuiev. All rights reserved.
//

#import "AZFBUserModelCashe.h"

@interface AZFBUserModelCashe ()
@property (nonatomic, strong) NSMapTable *cache;

@end

@implementation AZFBUserModelCashe

#pragma mark -
#pragma mark Class Methods

+ (instancetype)sharedCache {
    static dispatch_once_t onceToken;
    static id cache = nil;
    dispatch_once(&onceToken, ^{
        cache = [self new];
    });
    
    NSLog(@"%@",cache);
    
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
        self.cache = [NSMapTable strongToStrongObjectsMapTable];
    }
    
    return self;
}

#pragma mark -
#pragma mark Public Methods

- (void)setObject:(AZFBUserModel *)object forKey:(NSString *)key {
    NSLog(@"%lu set",(unsigned long)self.cache.count);
    @synchronized (self) {
        [self.cache setObject:object forKey:key];
    }
    NSLog(@"%lu set",(unsigned long)self.cache.count);
}

- (void)removeObjectForKey:(NSString *)key {
    @synchronized (self) {
        [self.cache removeObjectForKey:key];
    }
    //NSLog(@"%lu rem",(unsigned long)self.cache.count);
}

- (id)objectForKey:(NSString *)key {
    NSLog(@"%lu get",(unsigned long)self.cache.count);
    return [self.cache objectForKey:key];
}

@end
