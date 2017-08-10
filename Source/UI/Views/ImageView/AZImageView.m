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

static const double AZImageLoadDelay = 0.5;

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
}

#pragma mark -
#pragma mark Accessors

- (void)setContentImageView:(UIImageView *)contentImageView {
    if (_contentImageView != contentImageView) {
        [_contentImageView removeFromSuperview];
        _contentImageView = contentImageView;
        
        [self addSubview:contentImageView];
    }
}

#pragma mark -
#pragma mark Loading Model Observer

- (void)modelDidBecameUnloaded:(AZImageModel *)model {
    [super modelDidBecameUnloaded:model];
    
    self.contentImageView.image = nil;
}

- (void)modelDidBecameLoading:(AZImageModel *)model {
    
}

- (void)modelDidBecameLoaded:(AZImageModel *)model {
    [super modelDidBecameLoaded:model];
    
    self.model = model;
    self.contentImageView.image = model.image;
}

- (void)modelDidBecameFailedLoading:(AZImageModel *)model {
    [self.model load];
}

@end
