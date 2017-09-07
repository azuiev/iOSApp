//
//  AZContext.h
//  iOSApp
//
//  Created by Aleksey Zuiev on 01/09/2017.
//  Copyright © 2017 Aleksey Zuiev. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AZContext : NSObject

+ (instancetype)contextWithModel:(NSObject *)model;

- (void)execute;
- (void)cancel;

@end
