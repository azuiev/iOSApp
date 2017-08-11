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
    self.loadingView = [AZLoadingView initWithView:self];
}

#pragma mark -
#pragma mark Accessors

- (void)setModel:(AZImageModel *)model {
    if (_model != model) {
        [_model dump];
        
        [self.loadingView setModel:model];
        
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
        
        [self addSubview:contentImageView];
    }
}

#pragma mark -
#pragma mark Loading Model Observer

- (void)modelDidBecameUnloaded:(AZImageModel *)imageModel {
    self.contentImageView.image = nil;
}

- (void)modelDidBecameLoading:(AZImageModel *)imageModel {
    
}

- (void)modelDidBecameLoaded:(AZImageModel *)imageModel {
    self.model = imageModel;
    self.contentImageView.image = imageModel.image;
}

- (void)modelDidBecameFailedLoading:(AZImageModel *)imageModel {
    [self.model load];
}

@end
