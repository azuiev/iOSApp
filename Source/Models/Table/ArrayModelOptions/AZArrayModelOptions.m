//
//  AZArrayModelOptions.m
//  iOSApp
//
//  Created by Aleksey Zuiev on 27/07/2017.
//  Copyright © 2017 Aleksey Zuiev. All rights reserved.
//

#import "AZArrayModelOptions.h"

#import "AZArrayModelRemoveOption.h"

@implementation AZArrayModelOptions

+ (instancetype)arrayModelRemoveWithIndexes:(NSArray *)indexes {
    return [[AZArrayModelRemoveOption alloc] initWithIndexes:indexes];
}

- (id)modelOptions {
    return nil;
}

@end
