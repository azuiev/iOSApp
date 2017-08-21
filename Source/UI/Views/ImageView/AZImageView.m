//
//  AZImageView.m
//  iOSApp
//
//  Created by Aleksey Zuiev on 20/07/2017.
//  Copyright © 2017 Aleksey Zuiev. All rights reserved.
//

#import "AZImageView.h"

#import "AZGCD.h"
#import "AZMacros.h"
#import "AZViewConstants.h"

#import "UINib+AZExtension.h"

@implementation AZImageView

#pragma mark -
#pragma mark Initialization and Deallocation

- (void)dealloc {
    self.contentImageView = nil;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self initSubviews];
    }
    
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    
    if (!self.contentImageView) {
        [self initSubviews];
    }
}

- (void)initSubviews {
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:self.bounds];
    imageView.autoresizingMask = AZViewResizableWithFixedPosition;
    
    self.contentImageView = imageView;
    AZLoadingView *view = [UINib objectWithClass:[AZLoadingView class]];
    [view addAsSubiew:self bounds:self.contentImageView.bounds];
    
    self.loadingView = view;
}

#pragma mark -
#pragma mark Accessors

- (void)setLoadingView:(AZLoadingView *)loadingView {
    if (_loadingView != loadingView) {
        _loadingView = loadingView;
        
        [_loadingView startAnimating];
    }
}

- (void)setModel:(AZImageModel *)model {
    if (_model != model) {
        [_model setState:AZModelDidUnload];
        
        [_model removeObserver:self];
        
        _model = model;

        [_model addObserver:self];
        
        if (self.model == model) {
            [model load];
        }
    }
}

- (void)setContentImageView:(UIImageView *)contentImageView {
    if (_contentImageView != contentImageView) {
        [_contentImageView removeFromSuperview];
        _contentImageView = contentImageView;
        
        //_contentImageView.contentMode = UIViewContentModeTopLeft;
        
        [self addSubview:contentImageView];
    }
}

#pragma mark -
#pragma mark Loading Model Observer

- (void)modelDidUnload:(AZImageModel *)imageModel {
    [AZGCD dispatchAsyncOnMainQueue:^ {
        [self.loadingView startAnimating];
        
        self.contentImageView.image = nil;
    }];
}

- (void)modelWillLoad:(AZImageModel *)imageModel {
    
}

- (void)modelDidLoad:(AZImageModel *)imageModel {
    [AZGCD dispatchAsyncOnMainQueue:^ {
        [self.loadingView stopAnimating];
        
        self.contentImageView.image = imageModel.image;
    }];
}

- (void)modelDidFailLoad:(AZImageModel *)imageModel {
    [AZGCD dispatchAsyncOnMainQueue:^ {
        [self.model load];
    }];
}

@end
