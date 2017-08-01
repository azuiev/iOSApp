//
//  AZArrayModelChange.h
//  iOSApp
//
//  Created by Aleksey Zuiev on 27/07/2017.
//  Copyright © 2017 Aleksey Zuiev. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AZArrayModelChange : NSObject

+ (instancetype)arrayModelAddChange:(NSUInteger)index;
+ (instancetype)arrayModelRemoveChange:(NSUInteger)index;
+ (instancetype)arrayModelMoveChange:(NSUInteger)sourceIndex destinationIndex:(NSUInteger)destinationIndex;

//method to override in children classes. Do not call this method directly
- (NSUInteger)firstOption;
- (NSUInteger)secondOption;

@end
