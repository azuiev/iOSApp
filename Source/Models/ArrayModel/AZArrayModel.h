//
//  AZArrayModel.h
//  iOSApp
//
//  Created by Aleksey Zuiev on 21/07/2017.
//  Copyright © 2017 Aleksey Zuiev. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#import "AZArrayModelChange.h"
#import "AZModel.h"

@class AZArrayModel;
@class AZArrayModelOptions;

typedef NS_ENUM(NSUInteger, AZArrayModelState) {
    AZArrayModelChanged = AZModelStateCount
};

@protocol AZArrayModelObserver <NSObject>

@optional
- (void)arrayModelDidChange:(AZArrayModel *)arrayModel withObject:(AZArrayModelOptions *)object;

@end

@interface AZArrayModel : AZModel
@property (nonatomic, readonly) NSUInteger  count;
@property (nonatomic, readonly) NSArray     *array;

+ (instancetype)modelWithObjects:(NSArray *)objects;

- (instancetype)initWithArray:(NSArray *)array;

- (void)addObject:(NSObject *)object;
- (void)removeObject:(NSObject *)object;

- (void)addObjects:(NSArray *)objects;
- (void)removeObjects:(NSArray *)objects;

- (void)insertObject:(id)obj atIndex:(NSUInteger)index;
- (void)removeObjectAtIndex:(NSUInteger)index;

- (id)objectAtIndex:(NSUInteger)index;
- (void)setObject:(id)obj atIndex:(NSUInteger)index;

- (id)objectAtIndexedSubscript:(NSUInteger)index;
- (void)setObject:(id)obj atIndexedSubscript:(NSUInteger)index;

- (void)moveFromIndex:(NSUInteger)sourceIndex
              toIndex:(NSUInteger)destinationIndex;

- (void)performBlockWithNotification:(void(^)())block;
- (void)performBlockWithoutNotification:(void(^)())block;

@end
