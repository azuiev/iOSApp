//
//  NSBundle+AZExtension.m
//  iOSApp
//
//  Created by Aleksey Zuiev on 01/08/2017.
//  Copyright © 2017 Aleksey Zuiev. All rights reserved.
//

#import "NSBundle+AZExtension.h"

@implementation NSBundle (AZExtension)

- (UINib *)nibByClass:(Class)clazz {
    return [self nibByClass:clazz owner:nil options:nil];
}

- (UINib *)nibByClass:(Class)clazz owner:(id)owner {
    return [self nibByClass:clazz owner:owner options:nil];
}

- (UINib *)nibByClass:(Class)clazz options:(NSDictionary *)options {
    return [self nibByClass:clazz owner:nil options:options];
}

- (UINib *)nibByClass:(Class)clazz owner:(id)owner options:(NSDictionary *)options {
    return [[self loadNibNamed:NSStringFromClass(clazz)
                         owner:owner
                       options:options] firstObject];
}

@end
