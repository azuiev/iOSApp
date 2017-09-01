//
//  AZContext.m
//  iOSApp
//
//  Created by Aleksey Zuiev on 01/09/2017.
//  Copyright © 2017 Aleksey Zuiev. All rights reserved.
//

#import "AZContext.h"
#import "AZContextDispatcher.h"

@interface AZContext ()
@property (nonatomic, strong) NSOperation *operation;
@end

@implementation AZContext

#pragma mark -
#pragma mark Initialization and Deallocation

- (void)dealloc {
    [self.operation cancel];
    self.operation = nil;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        NSOperation *operation = [NSBlockOperation blockOperationWithBlock:^ {
            [self executeContext];
        }];
        
        [[[AZContextDispatcher sharedDispatcher] queue] addOperation:operation];
    }
    
    return self;
}
- (void)execute {
    NSOperation *operation = self.operation;
    if ([operation isReady] && ![operation isExecuting]) {
        [self.operation start];
    }
}

- (void)cancel {
    [self.operation cancel];
}

//method for children purposes. Do not call this method directly
- (void)executeContext {
    
}

@end
