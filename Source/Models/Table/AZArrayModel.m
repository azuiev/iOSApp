//
//  AZArrayModel.m
//  iOSApp
//
//  Created by Aleksey Zuiev on 21/07/2017.
//  Copyright © 2017 Aleksey Zuiev. All rights reserved.
//

#import "AZArrayModel.h"

#import "AZArrayModelChange.h"
#import "NSMutableArray+AZExtension.h"

@interface AZArrayModel ()
@property (nonatomic, strong) NSMutableArray    *mutableArray;

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

- (NSUInteger)count {
    return self.mutableArray.count;
}

#pragma mark -
#pragma mark Public Methods

- (void)addObject:(NSObject *)object {
    [self insertObject:object atIndex:self.count];
}

- (void)removeObject:(NSObject *)object {
    [self.mutableArray removeObject:object];
}

- (void)insertObject:(id)object atIndex:(NSUInteger)index {
    if (!object) {
        return;
    }
    
    NSMutableArray *array = self.mutableArray;
    if (array.count < index) {
        return;
    }
    
    [self.mutableArray insertObject:object atIndex:index];
    
    [self setState:AZArrayModelObjectAdded
     withParameter:[AZArrayModelChange arrayModelAddChange:index]];
}

- (void)removeObjectAtIndex:(NSUInteger)index {
    NSMutableArray *array = self.mutableArray;
    if (array.count <= index) {
        return;
    }
    
    [array removeObjectAtIndex:index];
    
    [self setState:AZArrayModelObjectRemoved
     withParameter:[AZArrayModelChange arrayModelRemoveChange:index]];
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

- (void)moveFromIndex:(NSUInteger)sourceIndex
              toIndex:(NSUInteger)destinationIndex
{
    if (sourceIndex == destinationIndex) {
        return;
    }
    
    NSMutableArray *array = self.mutableArray;
    
    [array moveFromIndex:sourceIndex toIndex:destinationIndex];
    
    [self setState:AZArrayModelObjectMoved
     withParameter:[AZArrayModelChange
                    arrayModelMoveChange:sourceIndex
                    destinationIndex:destinationIndex]];
}

#pragma mark -
#pragma mark Subscripts

- (id)objectAtIndexedSubscript:(NSUInteger)index NS_AVAILABLE(10_8, 6_0) {
    return [self objectAtIndex:index];
}

- (void)setObject: (id)obj atIndexedSubscript: (NSUInteger)index {
    return [self setObject:obj atIndex:index];
}

#pragma mark -
#pragma mark Observable Object

- (SEL)selectorForState:(NSUInteger)state {
    return @selector(arrayModelObjectChanged:modelChange:);
}

@end
