//
//  AZLoadingView.m
//  iOSApp
//
//  Created by Aleksey Zuiev on 10/08/2017.
//  Copyright © 2017 Aleksey Zuiev. All rights reserved.
//

#import "AZLoadingView.h"
#import "AZImageModel.h"

@implementation AZLoadingView

#pragma mark -
#pragma mark Class Methods

+ (instancetype)initWithView:(UIView *)view {
    return [[self alloc] initWithView:view bounds:view.bounds];
}

+ (instancetype)initWithView:(UIView *)view bounds:(CGRect)bounds {
    return [[self alloc] initWithView:view bounds:bounds];
}

- (instancetype)initWithView:(UIView *)view {
    return [self initWithView:view bounds:view.bounds];
}

- (instancetype)initWithView:(UIView *)view bounds:(CGRect)bounds {
    self = [super initWithFrame:bounds];
    if (self) {
        [self addAsSubiew:view bounds:bounds];
    }
    
    return self;
}

#pragma mark -
#pragma mark Initialization and Deadllocation

- (void)awakeFromNib {
    [super awakeFromNib];
    
    [self.activityIndicator startAnimating];
}

#pragma mark -
#pragma mark Public Methods

- (void)addAsSubiew:(UIView *)view {
    [self addAsSubiew:view bounds:view.bounds];
}

- (void)addAsSubiew:(UIView *)view bounds:(CGRect)bounds {
    self.frame = bounds;
    [view addSubview:self];
}

- (void)startAnimating {
    [self.activityIndicator startAnimating];
    [UIView animateWithDuration:1.0 animations:^ {
        self.alpha = 0.0;
        self.alpha = 1.0;
    }];
}

- (void)stopAnimating {
    [UIView animateWithDuration:1.0 animations:^ {
        self.alpha = 1.0;
        self.alpha = 0.0;
    }];
}

@end
