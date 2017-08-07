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

@implementation AZLoadingModel


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
    
    [self performLoading];
}

- (void)dump {
    self.state = AZModelDidUnload;
}

#pragma mark -
#pragma mark Private

- (void)performLoading {

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
