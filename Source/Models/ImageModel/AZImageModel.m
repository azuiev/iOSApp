//
//  AZImageModel.m
//  iOSApp
//
//  Created by Aleksey Zuiev on 16/07/2017.
//  Copyright © 2017 Aleksey Zuiev. All rights reserved.
//

#import "AZImageModel.h"

#import "AZImageModelDispatcher.h"

#import "AZMacros.h"

@interface AZImageModel ()
@property (nonatomic, strong) UIImage       *image;
@property (nonatomic, strong) NSURL         *url;
@property (nonatomic, strong) NSOperation   *operation;

- (NSOperation *)imageLoadingOperation;

@end
@implementation AZImageModel

#pragma mark -
#pragma mark Class methods

+ (instancetype)imageWithUrl:(NSURL *)url {
    return [[self alloc] initWithURL:url];
}

#pragma mark -
#pragma mark Initialization and Deallocation

- (void)dealloc {
    self.operation = nil;
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
            AZImageModelDispatcher *dispatcher = [AZImageModelDispatcher sharedDispatcher];
            [dispatcher.queue addOperation:operation];
        }
    }
}

#pragma mark -
#pragma mark Public methods

- (void)load {
    @synchronized (self) {
        NSUInteger state = self.state;
        if (AZImageModelLoading == state) {
            return;
        }
        
        if (AZImageModelLoaded == state) {
            [self notifyOfState:state];
            
            return;
        }
    
        self.state = AZImageModelLoading;
    }
   
    self.operation = [self imageLoadingOperation];

}

- (void)dump {
    self.operation = nil;
    self.image = nil;
    self.state = AZImageModelUnloaded;
}

#pragma mark -
#pragma mark Private

- (NSOperation *)imageLoadingOperation {
    AZWeakify(self);
    NSBlockOperation *operation = [NSBlockOperation blockOperationWithBlock:^{
        AZStrongify(self);
        self.image = [UIImage imageWithContentsOfFile:[self.url path]];
    }];
    
    operation.completionBlock = ^{
        AZStrongify(self);
        self.state = self.image ? AZImageModelLoaded : AZImageModelFailedLoading;
    };
    
    return operation;
}

#pragma mark -
#pragma mark Observable Object

- (SEL)selectorForState:(NSUInteger)state {
    switch (state) {
        case AZImageModelUnloaded:
            return @selector(imageModelDidBecameUnloaded:);
            
        case AZImageModelLoading:
            return @selector(imageModelDidBecameLoading:);
            
        case AZImageModelLoaded:
            return @selector(imageModelDidBecameLoaded:);
            
        case AZImageModelFailedLoading:
            return @selector(imageModelDidBecameFailedLoading:);
            
        default:
            return nil;
    }
}

@end
