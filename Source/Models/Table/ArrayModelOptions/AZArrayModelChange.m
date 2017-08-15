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
#import "AZArrayModelEditChange.h"
#import "AZArrayModelMultipleChange.h"

@implementation AZArrayModelChange

#pragma mark -
#pragma mark Class Methods

+ (instancetype)arrayModelRemoveChangeWithIndex:(NSUInteger)index {
    return [[AZArrayModelRemoveChange alloc] initWithIndex:index];
}

+ (instancetype)arrayModelAddChangeWithIndex:(NSUInteger)index {
    return [[AZArrayModelAddChange alloc] initWithIndex:index];
}

+ (instancetype)arrayModelEditChangeWithIndex:(NSUInteger)index {
    return [[AZArrayModelEditChange alloc] initWithIndex:index];
}

+ (instancetype)arrayModelMoveChangeFromIndex:(NSUInteger)sourceIndex toIndex:(NSUInteger)destinationIndex {
    return [[AZArrayModelMoveChange alloc] initWithSourceIndex:sourceIndex
                                             destinationIndex:destinationIndex];
}

+ (instancetype)arrayModelMultipleChange {
    return [AZArrayModelMultipleChange new];
}

#pragma mark -
#pragma mark Public Methods

- (NSIndexPath *)indexPathWithIndex:(NSUInteger)index section:(NSUInteger)section {
    return [NSIndexPath indexPathForRow:index inSection:section];
}

- (void)applyChangeToTableView:(UITableView *)tableView {
    [self applyChangeToTableView:tableView
                   withAnimation:UITableViewRowAnimationAutomatic
                       inSection:0];
}

- (void)applyChangeToTableView:(UITableView *)tableView
                 withAnimation:(UITableViewRowAnimation)animation
{
    [self applyChangeToTableView:tableView
                   withAnimation:animation
                       inSection:0];
}

- (void)applyChangeToTableView:(UITableView *)tableView
                 withAnimation:(UITableViewRowAnimation)animation
                     inSection:(NSUInteger)section
{
    [tableView beginUpdates];
    
    [self changeTableView:tableView
            withAnimation:animation
                inSection:section];
 
    [tableView endUpdates];
}

- (void)changeTableView:(UITableView *)tableView
          withAnimation:(UITableViewRowAnimation)animation
              inSection:(NSUInteger)section
{
    
}

@end
