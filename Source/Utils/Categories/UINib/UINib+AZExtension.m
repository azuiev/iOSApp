//
//  UINib+AZExtension.m
//  iOSApp
//
//  Created by Aleksey Zuiev on 16/07/2017.
//  Copyright © 2017 Aleksey Zuiev. All rights reserved.
//

#import "UINib+AZExtension.h"
#import "NSArray+AZExtension.h"

@implementation UINib (AZExtension)

#pragma mark -
#pragma mark Class methods

+ (UINib *)nibWithClass:(Class)cls {
    return [self nibWithClass:cls bundle:nil];
}

+ (UINib *)nibWithClass:(Class)cls bundle:(NSBundle *)bundle {
    return [UINib nibWithNibName:NSStringFromClass(cls)
                          bundle:bundle];
}

+ (id)objectWithClass:(Class)cls {
    return [self objectWithClass:cls bundle:nil];
}

+ (id)objectWithClass:(Class)cls bundle:(NSBundle *)bundle {
    return [[self nibWithClass:cls bundle:bundle] objectWithClass:cls];
}

#pragma mark -
#pragma mark ObjectWithClass

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
    NSArray *objects = [self instantiateWithOwner:owner options:options];
    
    return [objects firstObjectWithClass:cls];
}

@end
