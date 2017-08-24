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

- (void)addImageModel:(AZImageModel *)object withURL:(NSURL *)url;
- (void)removeObjectWithURL:(NSURL *)url;

- (BOOL)isCached:(NSURL *)url;
- (id)objectWithURL:(NSURL *)url;

@end
