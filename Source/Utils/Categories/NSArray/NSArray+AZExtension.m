//
//  NSArray+AZArrayByClass.m
//  idap
//
//  Created by Aleksey Zuiev on 08/05/2017.
//  Copyright © 2017 Aleksey Zuiev. All rights reserved.
//

#import "NSArray+AZExtension.h"

@implementation NSArray (AZExtension)

#pragma mark -
#pragma mark Class methods

+ (NSArray *)objectsWithCount:(NSUInteger)count block:(id(^)())block {
    if (!block) {
        return nil;
    }
    
    NSMutableArray *result = [NSMutableArray arrayWithCapacity:count];
    for (NSUInteger i = 0; i < count; i += 1) {
        result[i] = block();
    }
    
    return [NSArray arrayWithArray:result];
}

#pragma mark -
#pragma mark Initialization 

- (instancetype)objectsWithBlock:(BOOL(^)(id obj))block {
    if (!block) {
        return nil;
    }
    
    NSPredicate *predicate = [NSPredicate predicateWithBlock: ^BOOL(id obj, NSDictionary *bind) {
        return block(obj);
    }];
    
    return [self filteredArrayUsingPredicate:predicate];
}

#pragma mark -
#pragma mark Accessors

- (instancetype)objectsWithClass:(Class)cls {
    NSPredicate *predicate = [NSPredicate predicateWithBlock: ^BOOL(id obj, NSDictionary *bind) {
        return [obj isMemberOfClass:cls];
    }];
    
    return [self filteredArrayUsingPredicate:predicate];
}

- (id)firstObjectWithClass:(Class)cls {
    for (id object in self) {
        if ([object isMemberOfClass:cls]) {
            return object;
        }
    }
    
    return nil;
}

@end
