//
//  NSMutableArray+AZExtension.m
//  iOSApp
//
//  Created by Aleksey Zuiev on 01/08/2017.
//  Copyright © 2017 Aleksey Zuiev. All rights reserved.
//

#import "NSMutableArray+AZExtension.h"

@implementation NSMutableArray (AZExtension)

- (void)moveRowAtIndex:(NSUInteger)sourceIndex toIndex:(NSUInteger)destinationIndex {
    id object = [self objectAtIndex:sourceIndex];
    [self removeObjectAtIndex:sourceIndex];
    [self insertObject:object atIndex:destinationIndex];
}

@end
