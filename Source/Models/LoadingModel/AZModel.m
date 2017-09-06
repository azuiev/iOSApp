//
//  AZModel.m
//  iOSApp
//
//  Created by Aleksey Zuiev on 03/08/2017.
//  Copyright © 2017 Aleksey Zuiev. All rights reserved.
//

#import "AZModel.h"

#import "AZGCD.h"
#import "AZMacros.h"

@implementation AZModel

#pragma mark -
#pragma mark Public methods

- (void)load {
    @synchronized (self) {
        NSUInteger state = self.state;
        if (AZModelWillLoad == state || AZModelDidLoad == state) {
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
        [self performLoading];
    }];
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
            return @selector(modelDidLoad:);
        
        case AZModelWillLoad:
            return @selector(modelWillLoad:);
        
        case AZModelDidUnload:
            return @selector(modelDidUnload:);
           
        case AZModelDidFailLoad:
            return @selector(modelDidFailLoad:);
            
        default:
            return [super selectorForState:state];
    }
}

@end
