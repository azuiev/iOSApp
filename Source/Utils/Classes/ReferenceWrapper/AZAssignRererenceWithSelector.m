//
//  AZAssignRererenceWithSelector.m
//  idap
//
//  Created by Aleksey Zuiev on 18/06/2017.
//  Copyright © 2017 Aleksey Zuiev. All rights reserved.
//

#import "AZAssignRererenceWithSelector.h"

#import "AZMacros.h"

@interface AZAssignRererenceWithSelector ()
@property (nonatomic, assign) SEL   selector;
@property (nonatomic, weak) id      target;

@end

@implementation AZAssignRererenceWithSelector

@synthesize target = _target;

#pragma mark -
#pragma mark Class Methods

+ (instancetype)referenceWithTarger:(id)target selector:(SEL)selector {
    return [[self alloc] initWithTarget:target selector:(SEL)selector];
}

#pragma mark -
#pragma mark Initializations and Deallocations

- (instancetype)initWithTarget:(id)target selector:(SEL)selector {
    self = [super init];
    if (self) {
        self.target = target;
        self.selector = selector;
    }
    
    return self;
}

#pragma mark -
#pragma mark Public

- (void)performSelectorWithTarget {
    AZPragmaClangPushExpression("clang diagnostic ignored \"-Warc-performSelector-leaks\"");
    [self.target performSelector:self.selector];
    AZPragmaClangDiagnosticPop;
}

@end
