//
//  AZArrayModel.m
//  iOSApp
//
//  Created by Aleksey Zuiev on 21/07/2017.
//  Copyright © 2017 Aleksey Zuiev. All rights reserved.
//

#import "AZArrayModel.h"

@interface AZArrayModel ()
@property (nonatomic, copy) NSMutableArray    *mutableArray;

@end

@implementation AZArrayModel
@dynamic count;

#pragma mark -
#pragma mark Initialization and deallocation

+ (instancetype)modelWithObjects:(NSArray *)objects {
    return [[self alloc] initWithArray:objects];
}

#pragma mark -
#pragma mark Initialization and deallocation

- (void)dealloc {
    self.mutableArray = nil;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        self.mutableArray = [NSMutableArray array];
    }
    
    return self;
}

- (instancetype)initWithArray:(NSArray *)array {
    self = [self init];
    if (self) {
        [self.mutableArray addObjectsFromArray:array];
    }
    
    return self;
}


#pragma mark -
#pragma mark Accessors

- (NSArray *)array {
    return [self.mutableArray copy];
}

#pragma mark -
#pragma mark Public Methods

- (void)addObject:(NSObject *)object {
    if (!object) {
        return;
    }
    
    [self.mutableArray addObject:object];
}

- (void)removeObject:(NSObject *)object {
    [self.mutableArray removeObject:object];
}

- (void)insertObject:(id)object atIndex:(NSUInteger)index {
    if (!object) {
        return;
    }
    
    NSMutableArray *array = self.mutableArray;
    if (array.count <= index) {
        return;
    }
    
    [self.mutableArray insertObject:object atIndex:index];
}

- (void)removeObjectAtIndex:(NSUInteger)index {
    NSMutableArray *array = self.mutableArray;
    if (array.count <= index) {
        return;
    }
    
    [array removeObjectAtIndex:index];
}

- (id)objectAtIndex:(NSUInteger)index {
    NSMutableArray *array = self.mutableArray;
    if (array.count <= index) {
        return nil;
    }
    
    return [array objectAtIndex:index];
}

- (void)setObject:(id)object atIndex:(NSUInteger)index {
    if (!object) {
        return;
    }
    
    NSMutableArray *array = self.mutableArray;
    if (array.count <= index) {
        return;
    }
    
    [self.mutableArray setObject:object atIndexedSubscript:index];
}

#pragma mark -
#pragma mark Subscripts

- (id)objectAtIndexedSubscript:(NSUInteger)index NS_AVAILABLE(10_8, 6_0) {
    return [self objectAtIndex:index];
}

- (void)setObject: (id)obj atIndexedSubscript: (NSUInteger)index {
    return [self setObject:obj atIndex:index];
}

@end
