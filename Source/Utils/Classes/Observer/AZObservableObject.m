//
//  AZObservableObject.m
//  idap
//
//  Created by Aleksey Zuiev on 24/05/2017.
//  Copyright © 2017 Aleksey Zuiev. All rights reserved.
//

#import "AZObservableObject.h"

@interface AZObservableObject ()
@property (nonatomic, strong) NSMutableSet  *mutableObservers;

@end

@implementation AZObservableObject

@dynamic observers;

#pragma mark -
#pragma mark Initializations and Deallocations

- (void)dealloc {
    self.mutableObservers = nil;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        self.mutableObservers = [NSMutableSet set];
    }
    
    return self;
}

#pragma mark -
#pragma mark Accessors

- (instancetype)observers {
    NSSet *observers = self.mutableObservers;
    NSMutableArray *result = [NSMutableArray arrayWithCapacity:observers.count];
    for (AZAssignReference *reference in observers) {
        [result addObject: reference.target];
    }
    
    return [result copy];
}

- (void)setState:(NSUInteger)state {
    if (state != _state) {
        _state = state;
        
        [self notifyOfStateWithSelector:[self selectorForState:state]];
    }
}

- (void)setState:(NSUInteger)state withParameter:(id)parameter {
    if (state != _state) {
        _state = state;
    }
    
    [self notifyOfStateWithSelector:[self selectorForState:state] withParameter:(id)parameter];
}

#pragma mark -
#pragma mark Public

- (void)addObserver:(id)observer {
    if(observer) {
        [self.mutableObservers addObject:[AZAssignReference referenceWithTarger:observer]];
    }
}

- (void)removeObserver:(id)observer {
    [self.mutableObservers removeObject:[AZAssignReference referenceWithTarger:observer]];
}

- (void)addObservers:(NSArray *)observers {
    for (id observer in observers) {
        [self addObserver:observer];
    }
}

- (void)removeObservers:(NSArray *)observers {
    for (id observer in observers) {
        [self removeObserver:observer];
    }
}

- (BOOL)isObservedByObject:(id)object {
    return [self.mutableObservers containsObject:[AZAssignReference referenceWithTarger:object]];
}

#pragma mark -
#pragma mark Private

- (SEL)selectorForState:(NSUInteger)state {
    return NULL;
}

- (void)notifyOfState:(NSUInteger)state {
    return [self notifyOfStateWithSelector:[self selectorForState:state]];
}

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"

- (void)notifyOfStateWithSelector:(SEL)selector {
    NSMutableSet *observers = self.mutableObservers;
    for (AZAssignReference *reference in observers) {
        id target = reference.target;
        if ([target respondsToSelector:selector]) {
            [target performSelector:selector withObject:self];
        }
    }
}

- (void)notifyOfStateWithSelector:(SEL)selector withParameter:(id)parameter {
    NSMutableSet *observers = self.mutableObservers;
    for (AZAssignReference *reference in observers) {
        id target = reference.target;
        if ([target respondsToSelector:selector]) {
            [target performSelector:selector withObject:self withObject:parameter];
        }
    }
}

@end
