//
//  NSBundle+AZExtension.m
//  iOSApp
//
//  Created by Aleksey Zuiev on 01/08/2017.
//  Copyright © 2017 Aleksey Zuiev. All rights reserved.
//

#import "NSBundle+AZExtension.h"

@implementation NSBundle (AZExtension)

- (id)objectWithClass:(Class)clazz {
    return [self objectWithClass:clazz owner:nil options:nil];
}

- (id)objectWithClass:(Class)clazz owner:(id)owner {
    return [self objectWithClass:clazz owner:owner options:nil];
}

- (id)objectWithClass:(Class)clazz options:(NSDictionary *)options {
    return [self objectWithClass:clazz owner:nil options:options];
}

- (id)objectWithClass:(Class)clazz owner:(id)owner options:(NSDictionary *)options {
    return [[self loadNibNamed:NSStringFromClass(clazz)
                         owner:owner
                       options:options] firstObject];
}

@end
