//
//  AZArrayModel.h
//  iOSApp
//
//  Created by Aleksey Zuiev on 21/07/2017.
//  Copyright © 2017 Aleksey Zuiev. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#import "AZObservableObject.h"
#import "AZArrayModelOptions.h"

@class AZArrayModel;
@class AZArrayModelOptions;

typedef NS_ENUM(NSUInteger, AZArrayModelState) {
    AZArrayModelObjectAdded,
    AZArrayModelObjectRemoved
};

@protocol AZArrayModelObserver <NSObject>

@optional
- (void)arrayModelObjectAdded:(AZArrayModel *)arrayModel options:(AZArrayModelOptions *)options;
- (void)arrayModelObjectRemoved:(AZArrayModel *)arrayModel options:(AZArrayModelOptions *)options;

@end

@interface AZArrayModel : AZObservableObject
@property (nonatomic, readonly) NSUInteger  count;

+ (instancetype)modelWithObjects:(NSArray *)objects;

- (instancetype)initWithArray:(NSArray *)array;

- (void)addObject:(NSObject *)object;
- (void)removeObject:(NSObject *)object;

- (void)insertObject:(id)obj atIndex:(NSUInteger)index;
- (void)removeObjectAtIndex:(NSUInteger)index;

- (id)objectAtIndex:(NSUInteger)index;
- (void)setObject:(id)obj atIndex:(NSUInteger)index;

- (id)objectAtIndexedSubscript:(NSUInteger)index;
- (void)setObject:(id)obj atIndexedSubscript:(NSUInteger)index;

- (void)moveRowWithoutNotificationFromIndex:(NSUInteger)sourceIndex
                                    toIndex:(NSUInteger)destinationIndex;

@end
