//
//  AZArrayModelMoveChange.m
//  iOSApp
//
//  Created by Aleksey Zuiev on 01/08/2017.
//  Copyright © 2017 Aleksey Zuiev. All rights reserved.
//

#import "AZArrayModelMoveChange.h"

@interface AZArrayModelMoveChange ()
@property (nonatomic, assign) NSUInteger    sourceIndex;
@property (nonatomic, assign) NSUInteger    destinationIndex;

@end

@implementation AZArrayModelMoveChange

-  (instancetype)initWithSourceIndex:(NSUInteger)sourceIndex
                    destinationIndex:(NSUInteger)destinationIndex
{
    self = [super init];
    if (self) {
        self.sourceIndex = sourceIndex;
        self.destinationIndex = destinationIndex;
    }
    
    return self;
}

#pragma mark -
#pragma mark Accessors

- (NSUInteger)firstOption {
    return self.sourceIndex;
}

- (NSUInteger)secondOption {
    return self.destinationIndex;
}

@end