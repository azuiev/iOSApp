//
//  AZArrayModelRemoveOption.m
//  iOSApp
//
//  Created by Aleksey Zuiev on 27/07/2017.
//  Copyright © 2017 Aleksey Zuiev. All rights reserved.
//

#import "AZArrayModelRemoveOption.h"

@interface AZArrayModelRemoveOption ()
@property (nonatomic, strong) NSArray   *indexes;
@end

@implementation AZArrayModelRemoveOption

#pragma mark -
#pragma mark Initialization and Deallocation

- (void)dealloc {
    self.indexes = nil;
}

- (instancetype)initWithIndexes:(NSArray *)indexes; {
    self = [super init];
    if (self) {
        self.indexes = [NSArray arrayWithArray:indexes];
    }
    
    return self;
}

#pragma mark -
#pragma mark Accessors

- (id)modelOptions {
    return [self.indexes copy];
}

@end
