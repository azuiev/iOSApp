//
//  AZContextDispatcher.m
//  iOSApp
//
//  Created by Aleksey Zuiev on 17/07/2017.
//  Copyright © 2017 Aleksey Zuiev. All rights reserved.
//

#import "AZDispatcher.h"

@interface AZDispatcher ()
@property (nonatomic, strong) NSOperationQueue    *queue;

- (void)initQueue;

@end

@implementation AZDispatcher

#pragma mark -
#pragma mark Class methods

+ (instancetype)sharedDispatcher {
    static dispatch_once_t onceToken;
    static id dispatcher = nil;
    dispatch_once(&onceToken, ^{
        dispatcher = [self new];
    });
    
    return dispatcher;
}

#pragma mark -
#pragma mark Initialization and Deallocation

- (void)dealloc {
    self.queue = nil;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        [self initQueue];
    }
    
    return self;
}

- (void)initQueue {
    NSOperationQueue *queue = [NSOperationQueue new];
    queue.maxConcurrentOperationCount = 2;
    
    self.queue = queue;
}

#pragma mark -
#pragma mark Accessors

- (void)setQueue:(NSOperationQueue *)queue {
    if (_queue != queue) {
        [queue cancelAllOperations];
        
        _queue = queue;
    }
}

@end
