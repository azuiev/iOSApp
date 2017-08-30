//
//  AZView.m
//  iOSApp
//
//  Created by Aleksey Zuiev on 22/08/2017.
//  Copyright © 2017 Aleksey Zuiev. All rights reserved.
//

#import "AZView.h"

#import "UINib+AZExtension.h"

@implementation AZView

#pragma mark -
#pragma mark Initialization and Deallocation

- (void)dealloc {
    self.loadingView = nil;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self addLoadingView];
    }
    
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    
    [self addLoadingView];
}

- (void)addLoadingView {
    if (!self.loadingView) {
        AZLoadingView *view = [UINib objectWithClass:[AZLoadingView class]];
        [view addToSuperview:self];
        self.loadingView = view;
    }
}

#pragma mark -
#pragma mark Accessors

- (void)setLoadingView:(AZLoadingView *)loadingView {
    if (_loadingView != loadingView) {
        _loadingView = loadingView;
        
        [_loadingView setVisible:YES];
    }
}

@end
