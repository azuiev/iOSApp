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
    return [self initWithArray:nil];
}

- (instancetype)initWithArray:(NSArray *)array {
    self = [super init];
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
    @synchronized(self) {
        [self insertObject:object atIndex:self.count];
    }
}

- (void)removeObject:(NSObject *)object {
    @synchronized(self) {
        [self.mutableArray removeObject:object];
    }
}

- (void)insertObject:(id)object atIndex:(NSUInteger)index {
    @synchronized (self) {
        if (object && self.count >= index) {
            [self.mutableArray insertObject:object atIndex:index];
            
            [self setState:AZArrayModelChanged
                withObject:[AZArrayModelChange arrayModelAddChangeWithIndex:index]];
        }
    }
}

- (void)removeObjectAtIndex:(NSUInteger)index {
    @synchronized (self) {
        if (self.count > index) {
            [self.mutableArray removeObjectAtIndex:index];
            
            [self setState:AZArrayModelChanged
                withObject:[AZArrayModelChange arrayModelRemoveChangeWithIndex:index]];
        }
    }
}

- (id)objectAtIndex:(NSUInteger)index {
    if (self.count > index) {
        return [self.mutableArray objectAtIndex:index];
    }
    
    return nil;
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
#pragma mark NSCoding

- (instancetype)initWithCoder:(NSCoder *)coder {
    self = [super init];
    if (self) {
        self.mutableArray = [coder decodeObjectForKey:NSStringFromClass([self class])];
    }
    
    return self;
}

- (void)encodeWithCoder:(NSCoder *)coder {
    [coder encodeObject:self.mutableArray forKey:NSStringFromClass([self class])];
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
