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

+ (instancetype)modelWithObjects:(NSArray *)objects {
    return [[self alloc] initWithArray:objects];
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
        self.mutableArray = [NSMutableArray array];
        
        [self addObjects:array];
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

// object
- (void)addObject:(NSObject *)object {
    [self addObject:object withNotification:YES];
}

- (void)removeObject:(NSObject *)object {
    [self removeObject:object withNotification:YES];
}

// objects
- (void)addObjects:(NSArray *)objects {
    void(^AZAddBlock)(id) = ^(id object) {
        [self addObject:object withNotification:NO];
    };
    
    [self performBlockOnArray:objects block:AZAddBlock];
}

- (void)removeObjects:(NSArray *)objects {
    void(^AZRemoveBlock)(id) = ^(id object) {
        [self removeObject:object withNotification:NO];
    };
    
    [self performBlockOnArray:objects block:AZRemoveBlock];
}

// object with index

- (void)removeObjectAtIndex:(NSUInteger)index {
    [self removeObjectAtIndex:index withNotification:YES];
}

- (void)insertObject:(id)object atIndex:(NSUInteger)index {
    [self insertObject:object atIndex:index withNotification:YES];
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
            
            [self setState:AZArrayModelChanged
                withObject:[AZArrayModelChange
                            arrayModelMoveChangeFromIndex:sourceIndex
                            toIndex:destinationIndex]];
        }
    }
}

#pragma mark -
#pragma mark Private Methods

- (void)addObject:(NSObject *)object withNotification:(BOOL)notify {
    [self insertObject:object atIndex:self.mutableArray.count withNotification:notify];
}

- (void)insertObject:(id)object atIndex:(NSUInteger)index withNotification:(BOOL)notify {
    @synchronized (self) {
        if (object && self.count >= index) {
            [self.mutableArray insertObject:object atIndex:index];
            
            if (notify) {
                [self setState:AZArrayModelChanged
                    withObject:[AZArrayModelChange arrayModelAddChangeWithIndex:index]];
            }
        }
    }
}

- (void)removeObject:(NSObject *)object withNotification:(BOOL)notify {
    @synchronized(self) {
        NSUInteger index = [self.mutableArray indexOfObject:object];
        [self removeObjectAtIndex:index withNotification:notify];
    }
}

- (void)removeObjectAtIndex:(NSUInteger)index withNotification:(BOOL)notify {
    @synchronized (self) {
        if (self.count > index) {
            [self.mutableArray removeObjectAtIndex:index];
            
            if (notify) {
                [self setState:AZArrayModelChanged
                    withObject:[AZArrayModelChange arrayModelRemoveChangeWithIndex:index]];
            }
        }
    }
}

- (void)performBlockOnArray:(NSArray *)array block:(void(^)(id))block {
    for (id object in array) {
        block(object);
    }
    
    [self setState:AZArrayModelChanged
        withObject:[AZArrayModelChange arrayModelMultipleChange]];
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
    if (AZArrayModelChanged == state) {
        return @selector(arrayModelDidChange:withObject:);
    } else {
        return [super selectorForState:state];
    }
}

@end
