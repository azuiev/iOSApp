//
//  AZCache.h
//  iOSApp
//
//  Created by Aleksey Zuiev on 18/08/2017.
//  Copyright © 2017 Aleksey Zuiev. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "AZImageModel.h"

@interface AZImageModelCache : NSObject

+ (instancetype)sharedCache;

- (void)setObject:(AZImageModel *)object forKey:(NSURL *)key;
- (void)removeObjectForKey:(NSURL *)key;

- (id)objectForKey:(NSURL *)key;

@end
