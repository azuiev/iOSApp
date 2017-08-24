//
//  NSBundle+AZExtension.m
//  iOSApp
//
//  Created by Aleksey Zuiev on 01/08/2017.
//  Copyright © 2017 Aleksey Zuiev. All rights reserved.
//

#import "NSBundle+AZExtension.h"

@implementation NSBundle (AZExtension)

- (id)objectWithClass:(Class)cls {
    return [self objectWithClass:cls owner:nil options:nil];
}

- (id)objectWithClass:(Class)cls owner:(id)owner {
    return [self objectWithClass:cls owner:owner options:nil];
}

- (id)objectWithClass:(Class)cls options:(NSDictionary *)options {
    return [self objectWithClass:cls owner:nil options:options];
}

- (id)objectWithClass:(Class)cls owner:(id)owner options:(NSDictionary *)options {
    return [[self loadNibNamed:NSStringFromClass(cls)
                         owner:owner
                       options:options] firstObject];
}

@end
