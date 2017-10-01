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
@dynamic array;

#pragma mark -
#pragma mark Initialization and deallocation

+ (instancetype)arrayModelWithArray:(NSArray *)array {
    return [[self alloc] initWithArray:array];
}

#pragma mark -
#pragma mark Initialization and deallocation

- (void)dealloc {
    self.mutableArray = nil;
}

- (instancetype)init {
    return [self initWithArray:nil];
}

- (instancetype)initWithArray:(NSArray *)array {
    self = [super init];
    if (self) {
        self.mutableArray = [NSMutableArray arrayWithArray:array];
        self.notify = YES;
    }
    
    return self;
}

#pragma mark -
#pragma mark Accessors

- (NSArray *)array {
    @synchronized (self) {
        return [self.mutableArray copy];
    }
}

- (NSUInteger)count {
    @synchronized (self) {
        return self.mutableArray.count;
    }
}

#pragma mark -
#pragma mark Public Methods

- (void)addObject:(NSObject *)object {
    [self insertObject:object atIndex:self.count];
}

- (void)removeObject:(NSObject *)object {
    [self removeObjectAtIndex:[self.array indexOfObject:object]];
}

- (void)addObjects:(NSArray *)objects {
    for (id object in objects) {
        [self addObject:object];
    }
}

- (void)removeObjects:(NSArray *)objects {
    for (id object in objects) {
        [self removeObject:object];
    }
}

- (id)objectAtIndex:(NSUInteger)index {
    return self.count > index ? [self.mutableArray objectAtIndex:index] : nil;
}

- (void)setObject:(id)object atIndex:(NSUInteger)index {
    @synchronized (self) {
        if (object && self.count > index) {
            [self.mutableArray setObject:object atIndexedSubscript:index];
        }
    }
}

- (void)moveFromIndex:(NSUInteger)sourceIndex
              toIndex:(NSUInteger)destinationIndex
{
    @synchronized (self) {
        if (sourceIndex != destinationIndex) {
            [self.mutableArray moveRowAtIndex:sourceIndex toIndex:destinationIndex];
            [self notifyWithObject:[AZArrayModelChange arrayModelMoveChangeFromIndex:sourceIndex
                                                                             toIndex:destinationIndex]];
        }
    }
}

#pragma mark -
#pragma mark Private Methods

- (void)insertObject:(id)object atIndex:(NSUInteger)index {
    @synchronized (self) {
        if (object && self.count >= index) {
            [self.mutableArray insertObject:object atIndex:index];
            [self notifyWithObject:[AZArrayModelChange arrayModelAddChangeWithIndex:index]];
        }
    }
}

- (void)removeObjectAtIndex:(NSUInteger)index {
    @synchronized (self) {
        if (self.count > index) {
            [self.mutableArray removeObjectAtIndex:index];
            [self notifyWithObject:[AZArrayModelChange arrayModelRemoveChangeWithIndex:index]];
        }
    }
}

- (void)notifyWithObject:(AZArrayModelChange *)arrayModelChange {
    [self setState:AZArrayModelChanged withObject:arrayModelChange];
}

#pragma mark -
#pragma mark Subscripts

- (id)objectAtIndexedSubscript:(NSUInteger)index NS_AVAILABLE(10_8, 6_0) {
    return [self objectAtIndex:index];
}

- (void)setObject:(id)obj atIndexedSubscript:(NSUInteger)index {
    return [self setObject:obj atIndex:index];
}

#pragma mark -
#pragma mark Observable Object

- (SEL)selectorForState:(NSUInteger)state {
    switch (state) {
        case AZArrayModelChanged:
            return @selector(arrayModelDidChange:withObject:);
            
        default:
            return [super selectorForState:state];
    }
}

@end
