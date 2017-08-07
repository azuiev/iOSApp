//
//  AZLoadingModel.m
//  iOSApp
//
//  Created by Aleksey Zuiev on 03/08/2017.
//  Copyright © 2017 Aleksey Zuiev. All rights reserved.
//

#import "AZLoadingModel.h"

#import "AZLoadingModelDispatcher.h"

#import "AZGCD.h"
#import "AZMacros.h"

@implementation AZLoadingModel

#pragma mark -
#pragma mark Initialization and deallocations

- (instancetype)init {
    self = [super init];
    if (self) {
        self.state = AZModelDidUnload;
    }
    
    return self;
}
#pragma mark -
#pragma mark Public methods

- (void)load {
    @synchronized (self) {
        NSUInteger state = self.state;
        if (AZModelWillLoad == state) {
            return;
        }
        
        if (AZModelDidLoad == state) {
            [self notifyOfState:state];
            
            return;
        }
        
        self.state = AZModelWillLoad;
    }
    
    [self loadObject];
}

- (void)loadObject {
    AZWeakify(self);
    [AZGCD dispatchAsyncOnBackground:^ {
        AZStrongify(self);
        id object = [self performLoading];
        self.state = object ? AZModelDidLoad : AZModelDidFailLoad;
    }];
}

- (void)dump {
    self.state = AZModelDidUnload;
}

#pragma mark -
#pragma mark Private

- (id)performLoading {
    return nil;
}

#pragma mark -
#pragma mark Observable object

- (SEL)selectorForState:(NSUInteger)state {
    switch (state) {
        case AZModelDidLoad:
            return @selector(modelDidBecameLoaded:);
        
        case AZModelWillLoad:
            return @selector(modelDidBecameLoading:);
        
        case AZModelDidUnload:
            return @selector(modelDidBecameUnloaded:);
           
        case AZModelDidFailLoad:
            return @selector(modelDidBecameFailedLoading:);
            
        default:
            return nil;
    }
}

@end
