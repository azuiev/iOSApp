//
//  AZLoadingView.m
//  iOSApp
//
//  Created by Aleksey Zuiev on 10/08/2017.
//  Copyright © 2017 Aleksey Zuiev. All rights reserved.
//

#import "AZLoadingView.h"

@implementation AZLoadingView


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
#pragma mark Accessors

- (void)setModel:(AZModel *)model {
    if (_model != model) {
        [_model dump];
        [_model removeObserver:self];
        
        _model = model;
        [_model addObserver:self];
        
        if (self.model == model) {
            [model load];
        }
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
