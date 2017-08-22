//
//  AZArrayModelChange.h
//  iOSApp
//
//  Created by Aleksey Zuiev on 27/07/2017.
//  Copyright © 2017 Aleksey Zuiev. All rights reserved.
//
#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

@interface AZArrayModelChange : NSObject

+ (instancetype)arrayModelAddChangeWithIndex:(NSUInteger)index;
+ (instancetype)arrayModelRemoveChangeWithIndex:(NSUInteger)index;
+ (instancetype)arrayModelEditChangeWithIndex:(NSUInteger)index;
+ (instancetype)arrayModelMoveChangeFromIndex:(NSUInteger)sourceIndex
                                      toIndex:(NSUInteger)destinationIndex;

- (void)applyChangeToTableView:(UITableView *)tableView;

- (void)applyChangeToTableView:(UITableView *)tableView
                 withAnimation:(UITableViewRowAnimation)animation;

- (void)applyChangeToTableView:(UITableView *)tableView
                 withAnimation:(UITableViewRowAnimation)animation
                     inSection:(NSUInteger)section;

//method to override in children classes. Do not call this method directly
- (void)changeTableView:(UITableView *)tableView
          withAnimation:(UITableViewRowAnimation)animation
              inSection:(NSUInteger)section;

//methods for chidren purposes
- (NSIndexPath *)indexPathWithIndex:(NSUInteger)index section:(NSUInteger)section;

@end
