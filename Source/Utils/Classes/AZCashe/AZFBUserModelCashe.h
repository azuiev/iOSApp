//
//  AZFBUserModelCashe.h
//  iOSApp
//
//  Created by Aleksey Zuiev on 29/09/2017.
//  Copyright © 2017 Aleksey Zuiev. All rights reserved.
//

#import "AZContext.h"

#import "AZFBUserModel.h"

@interface AZFBUserModelCashe : AZContext

+ (instancetype)sharedCache;

- (void)setObject:(AZFBUserModel *)object forKey:(NSString *)key;
- (void)removeObjectForKey:(NSString *)key;

- (id)objectForKey:(NSString *)key;

@end
