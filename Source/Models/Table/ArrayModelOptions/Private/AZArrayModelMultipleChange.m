//
//  AZArrayModelMultipleChange.m
//  iOSApp
//
//  Created by Aleksey Zuiev on 16/08/2017.
//  Copyright © 2017 Aleksey Zuiev. All rights reserved.
//

#import "AZArrayModelMultipleChange.h"

@implementation AZArrayModelMultipleChange

- (void)changeTableView:(UITableView *)tableView
          withAnimation:(UITableViewRowAnimation)animation
              inSection:(NSUInteger)section
{
    [tableView reloadData];
}

@end
