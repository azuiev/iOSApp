//
//  AZImageModelDispatcher.h
//  iOSApp
//
//  Created by Aleksey Zuiev on 17/07/2017.
//  Copyright © 2017 Aleksey Zuiev. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AZImageModelDispatcher : NSObject
@property (nonatomic, readonly) NSOperationQueue    *queue;

+ (instancetype)sharedDispatcher;

@end