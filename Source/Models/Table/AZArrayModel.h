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

@interface AZArrayModel : AZObservableObject
@property (nonatomic, readonly) NSArray *array;

- (void)addObject:(NSObject *)object;
- (void)removeObject:(NSObject *)object;

- (id)objectAtIndex:(NSUInteger)index;
- (void)setObject:(id)obj atIndex:(NSUInteger)index;

- (id)objectAtIndexedSubscript:(NSUInteger)index;
- (void)setObject:(id)obj atIndexedSubscript:(NSUInteger)index;

@end
