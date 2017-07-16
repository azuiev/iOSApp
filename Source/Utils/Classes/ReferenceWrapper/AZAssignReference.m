//
//  AZAssignReference.m
//  idap
//
//  Created by Aleksey Zuiev on 25/05/2017.
//  Copyright © 2017 Aleksey Zuiev. All rights reserved.
//

#import "AZAssignReference.h"

@interface AZAssignReference ()
@property (nonatomic, assign)   id  target;

@end

@implementation AZAssignReference

#pragma mark -
#pragma mark Class Methods

+ (instancetype)referenceWithTarger:(id)target {
    return [[self alloc] initWithTarget:target];
}

#pragma mark -
#pragma mark Initializations and Deallocations

- (instancetype)initWithTarget:(id)target {
    self = [super init];
    if (self) {
        self.target = target;
    }
    
    return self;
}

#pragma mark -
#pragma mark Public

- (NSUInteger)hash {
    return (NSUInteger)self.target;
}

- (BOOL)isEqual:(id)object {
    if (!object) {
        return NO;
    }
    
    if (self == object) {
        return YES;
    }
    
    if (![object isMemberOfClass:[self class]]) {
        return NO;
    }
    
    return [self isEqualToReference:object];
}

- (BOOL)isEqualToReference:(AZAssignReference *)reference {
    return self.target == reference.target;
}

@end
