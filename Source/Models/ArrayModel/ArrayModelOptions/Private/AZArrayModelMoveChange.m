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
#pragma mark Override methods

- (void)changeTableView:(UITableView *)tableView
          withAnimation:(UITableViewRowAnimation)animation
              inSection:(NSUInteger)section
{
    NSIndexPath *sourceIndexPath = [self indexPathWithIndex:self.sourceIndex section:section];
    NSIndexPath *destinationIndexPath = [self indexPathWithIndex:self.destinationIndex section:section];
    
    [tableView moveRowAtIndexPath:sourceIndexPath toIndexPath:destinationIndexPath];
}


@end
