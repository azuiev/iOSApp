//
//  AZArrayModelChange.m
//  iOSApp
//
//  Created by Aleksey Zuiev on 27/07/2017.
//  Copyright © 2017 Aleksey Zuiev. All rights reserved.
//

#import "AZArrayModelChange.h"

#import "AZArrayModelAddChange.h"
#import "AZArrayModelRemoveChange.h"
#import "AZArrayModelMoveChange.h"

@implementation AZArrayModelChange

#pragma mark -
#pragma mark Class Methods

+ (instancetype)arrayModelRemoveChangeWithIndex:(NSUInteger)index {
    return [[AZArrayModelRemoveChange alloc] initWithIndex:index];
}

+ (instancetype)arrayModelAddChangeWithIndex:(NSUInteger)index {
    return [[AZArrayModelAddChange alloc] initWithIndex:index];
}

+ (instancetype)arrayModelMoveChangeFromIndex:(NSUInteger)sourceIndex toIndex:(NSUInteger)destinationIndex {
    return [[AZArrayModelMoveChange alloc] initWithSourceIndex:sourceIndex
                                             destinationIndex:destinationIndex];
}

#pragma mark -
#pragma mark Public Methods

- (NSIndexPath *)indexPathWithIndex:(NSUInteger)index {
    return [NSIndexPath indexPathForRow:index inSection:0];
}

- (void)applyChangeToTalbeView:(UITableView *)tableView {
    
}

@end
