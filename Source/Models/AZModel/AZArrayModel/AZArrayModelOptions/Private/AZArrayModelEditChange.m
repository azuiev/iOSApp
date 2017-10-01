//
//  AZArrayModelEditChange.m
//  iOSApp
//
//  Created by Aleksey Zuiev on 16/08/2017.
//  Copyright © 2017 Aleksey Zuiev. All rights reserved.
//

#import "AZArrayModelEditChange.h"

@interface AZArrayModelEditChange ()
@property (nonatomic, assign) NSUInteger    index;
@end

@implementation AZArrayModelEditChange

#pragma mark -
#pragma mark Initialization and Deallocation

-  (instancetype)initWithIndex:(NSUInteger)index {
    self = [super init];
    if (self) {
        self.index = index;
    }
    
    return self;
}

#pragma mark -
#pragma mark Override methods

- (void)changeTableView:(UITableView *)tableView
          withAnimation:(UITableViewRowAnimation)animation
              inSection:(NSUInteger)section
{
    NSIndexPath *indexPath = [self indexPathWithIndex:self.index section:section];
    
    [tableView reloadRowsAtIndexPaths:@[indexPath]
                     withRowAnimation:animation];
}

@end
