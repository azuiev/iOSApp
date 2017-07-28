//
//  AZGCD.h
//  idap
//
//  Created by Aleksey Zuiev on 27/06/2017.
//  Copyright © 2017 Aleksey Zuiev. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AZGCD : NSObject

+ (dispatch_queue_t)dispatchGetMainQueue;
+ (dispatch_queue_t)dispatchGetBackgroundQueue;
+ (dispatch_queue_t)dispatchGetQueueWithQOS:(dispatch_qos_class_t)QOSClass;

+ (void)dispatchSyncOnBackground:(void(^)())block;
+ (void)dispatchAsyncOnBackground:(void(^)())block;

+ (void)dispatchSyncOnMainQueue:(void(^)())block;
+ (void)dispatchAsyncOnMainQueue:(void(^)())block;

+ (void)dispatchSyncOnQueue:(dispatch_queue_t)queue block:(void (^)())block;
+ (void)dispatchAsyncOnQueue:(dispatch_queue_t)queue block:(void (^)())block;

+ (void)dispatchAfterDelay:(double)delay block:(void(^)())block;
+ (void)dispatchAfterDelay:(double)delay withCondition:(BOOL(^)())condition block:(void(^)())block;

@end
