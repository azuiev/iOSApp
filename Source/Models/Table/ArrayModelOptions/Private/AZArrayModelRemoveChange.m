//
//  AZArrayModelRemoveChange.m
//  iOSApp
//
//  Created by Aleksey Zuiev on 27/07/2017.
//  Copyright © 2017 Aleksey Zuiev. All rights reserved.
//

#import "AZArrayModelRemoveChange.h"

@interface AZArrayModelRemoveChange ()
@property (nonatomic, assign) NSUInteger    index;
@end

@implementation AZArrayModelRemoveChange

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

- (void)applyChangeToTalbeView:(UITableView *)tableView {
    NSIndexPath *indexPath = [self indexPathWithIndex:self.index];
    
    [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath]
                     withRowAnimation:UITableViewRowAnimationFade];
}

@end
