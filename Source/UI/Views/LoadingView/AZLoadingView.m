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

+ (instancetype)initWithView:(UIView *)view{
   return [[self alloc] initWithView:view];
}

- (instancetype)initWithView:(UIView *)view{
    self = [super initWithFrame:view.frame];
    if (self) {
        [self initSubviews];
        
        [view addSubview:self];
    }
    
    return self;
}

#pragma mark -
#pragma mark Initialization and Deadllocation

- (void)awakeFromNib {
    [super awakeFromNib];
    
    if (!self.activityIndicator) {
        [self initSubviews];
    }
}

- (void)initSubviews {
    UIActivityIndicatorView *activityIndicator = [[UIActivityIndicatorView alloc]
                                                  initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    activityIndicator.alpha = 1.0;
    
    [activityIndicator startAnimating];
        
    self.activityIndicator = activityIndicator;
}

#pragma mark -
#pragma mark Accessors

- (void)setModel:(AZModel *)model {
    if (_model != model) {
        [_model removeObserver:self];
        
        _model = model;
        [_model addObserver:self];
    }
}

#pragma mark -
#pragma mark Model Observer

- (void)modelDidBecameLoaded:(AZModel *)model {
    self.activityIndicator.alpha = 0;
}

- (void)modelDidBecameLoading:(AZModel *)model {
    
}

- (void)modelDidBecameUnloaded:(AZModel *)model {
    self.activityIndicator.alpha = 1.0;
}

- (void)modelDidBecameFailedLoading:(AZModel *)model {
    
}

@end
