//
//  AZLoadingView.m
//  iOSApp
//
//  Created by Aleksey Zuiev on 10/08/2017.
//  Copyright © 2017 Aleksey Zuiev. All rights reserved.
//

#import "AZLoadingView.h"

@implementation AZLoadingView

#pragma mark -
#pragma mark Class Methods

+ (instancetype)initWithView:(UIView *)view {
    return [[self alloc] initWithView:view];
}

- (instancetype)initWithView:(UIView *)view {
    self = [super initWithFrame:view.frame];
    if (self) {
        
    }
    
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    
    if (!self.activityIndicator) {
        [self initIndicator];
    }
}

- (void)initIndicator {
    UIActivityIndicatorView *activityIndicator = [[UIActivityIndicatorView alloc] initWithFrame:self.frame];
    self.activityIndicator = activityIndicator;
    [activityIndicator setAlpha:1.0];
    [activityIndicator startAnimating];
}

#pragma mark -
#pragma mark Observer

- (void)setModel:(AZModel *)model {
    if (_model != model) {
        [_model removeObserver:self];
        
        _model = model;
        [_model addObserver:self];
    }
}

#pragma mark -
#pragma mark Observer

- (void)modelDidBecameLoaded:(AZModel *)loadingModel {
    self.activityIndicator.alpha = 0;
}

- (void)modelDidBecameLoading:(AZModel *)loadingModel {
    
}

- (void)modelDidBecameUnloaded:(AZModel *)loadingModel {
    self.activityIndicator.alpha = 1.0;
}

- (void)modelDidBecameFailedLoading:(AZModel *)loadingModel {
    
}

@end
