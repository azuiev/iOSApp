//
//  AZLoadingModel.m
//  iOSApp
//
//  Created by Aleksey Zuiev on 03/08/2017.
//  Copyright © 2017 Aleksey Zuiev. All rights reserved.
//

#import "AZLoadingModel.h"

#import "AZLoadingModelDispatcher.h"

#import "AZMacros.h"

@interface AZLoadingModel ()
@property (nonatomic, strong)   id          object;
@property (nonatomic, strong)   NSURL       *url;
@property (nonatomic, strong)   NSOperation *operation;
@end

@implementation AZLoadingModel

#pragma mark -
#pragma mark Class methods

+ (instancetype)modelWithURL:(NSURL *)url {
    return [[self alloc] initWithURL:url];
}

#pragma mark -
#pragma mark Initialization and Deallocation

- (void)dealloc {
    self.operation = nil;
    self.object = nil;
    self.url = nil;
}

- (instancetype)initWithURL:(NSURL *)url {
    self = [super init];
    if (self) {
        self.url = url;
    }
    
    return self;
}

#pragma mark -
#pragma mark Accessors

- (void)setOperation:(NSOperation *)operation {
    if (_operation != operation) {
        [_operation cancel];
        
        _operation = operation;
        
        if (operation) {
            AZLoadingModelDispatcher *dispatcher = [AZLoadingModelDispatcher sharedDispatcher];
            [dispatcher.queue addOperation:operation];
        }
    }
}

#pragma mark -
#pragma mark Public methods

- (void)load {
    @synchronized (self) {
        NSUInteger state = self.state;
        if (AZModelLoading == state) {
            return;
        }
        
        if (AZModelLoaded == state) {
            [self notifyOfState:state];
            
            return;
        }
        
        self.state = AZModelLoading;
    }
    
    self.operation = [self loadingOperation];
    
}

- (void)saveToURL:(NSURL *)url {
    
}

- (id)modelWithURL:(NSURL *)url {
    return nil;
}

- (void)dump {
    self.operation = nil;
    self.object = nil;
    self.state = AZModelUnloaded;
}

#pragma mark -
#pragma mark Private

- (NSOperation *)loadingOperation {
    AZWeakify(self);
    NSBlockOperation *operation = [NSBlockOperation blockOperationWithBlock:^{
        AZStrongify(self);
        self.object = [self modelWithURL:self.url];
    }];
    
    operation.completionBlock = ^{
        AZStrongifyAndReturnIfNil(self);
        self.state = self.object ? AZModelLoaded : AZModelFailedLoading;
    };
    
    return operation;
}

#pragma mark -
#pragma mark Observable object

- (SEL)selectorForState:(NSUInteger)state {
    switch (state) {
        case AZModelUnloaded:
            return @selector(modelDidBecameUnloaded:);
            
        case AZModelLoading:
            return @selector(modelDidBecameLoading:);
            
        case AZModelLoaded:
            return @selector(modelDidBecameLoaded:);
            
        case AZModelFailedLoading:
            return @selector(modelDidBecameFailedLoading:);
            
        default:
            return nil;
    }
}

@end
