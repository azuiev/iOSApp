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
}

#pragma mark -
#pragma mark Accessors

- (void)setImageModel:(AZImageModel *)imageModel {
    if (_imageModel != imageModel) {
        [_imageModel dump];
        [_imageModel removeObserver:self];
        
        _imageModel = imageModel;
        [_imageModel addObserver:self];
        
        if (self.imageModel == _imageModel) {
            [_imageModel load];
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
    self.imageModel = imageModel;
    self.contentImageView.image = imageModel.image;
}

- (void)modelDidBecameFailedLoading:(AZImageModel *)imageModel {
    [self.imageModel load];
}

@end
