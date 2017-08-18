//
//  AZCashe.h
//  iOSApp
//
//  Created by Aleksey Zuiev on 18/08/2017.
//  Copyright © 2017 Aleksey Zuiev. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AZCashe : NSObject

+ (instancetype)sharedCashe;

- (void)addObject:(id)object forKey:(id)key;
- (void)removeKey:(id)key;

- (BOOL)isCashed:(id)key;
- (id)objectForKey:(id)key;

- (NSArray *)getAllKeys;

@end
