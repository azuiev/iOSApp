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
@dynamic array;

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

#pragma mark -
#pragma mark Accessors

- (NSArray *)array {
    return [self.mutableArray copy];
}

#pragma mark -
#pragma mark Public Methods

- (void)addObject:(NSObject *)object {
    [self.mutableArray addObject:object];
}

- (void)removeObject:(NSObject *)object {
    [self.mutableArray removeObject:object];
}

- (id)objectAtIndex:(NSUInteger)index {
    NSMutableArray *array = self.mutableArray;
    if (array.count <= index) {
        return nil;
    }
    
    return [array objectAtIndex:index];
}

- (void)setObject:(id)obj atIndex:(NSUInteger)index {
    
}

- (id)objectAtIndexedSubscript:(NSUInteger)index NS_AVAILABLE(10_8, 6_0) {
    NSMutableArray *array = self.mutableArray;
    if (array.count <= index) {
        return nil;
    }
    
    return [array objectAtIndexedSubscript:index];
}

- (void)setObject: (id)obj atIndexedSubscript: (NSUInteger)index {
    NSMutableArray *array = self.mutableArray;
    if (array.count <= index) {
        return;
    }
    
    [array setObject:obj atIndexedSubscript:index];
}

@end
