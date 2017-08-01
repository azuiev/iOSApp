//
//  NSArray+AZArrayByClass.h
//  idap
//
//  Created by Aleksey Zuiev on 08/05/2017.
//  Copyright © 2017 Aleksey Zuiev. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSArray (AZExtension)

+ (NSArray *)objectsWithCount:(NSUInteger)count block:(id(^)())block;

- (instancetype)objectsWithClass:(Class)cls;
- (instancetype)objectsWithBlock:(BOOL(^)(id obj))block;

@end
