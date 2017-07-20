//
//  AZImageView.m
//  iOSApp
//
//  Created by Aleksey Zuiev on 20/07/2017.
//  Copyright © 2017 Aleksey Zuiev. All rights reserved.
//

#import "AZImageView.h"

@implementation AZImageView

#pragma mark -
#pragma mark Initialization and Deallocation

- (void)dealloc {
    self.contentImageView = nil;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        
    }
    
    return self;
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
    imageView.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin
                                | UIViewAutoresizingFlexibleWidth
                                | UIViewAutoresizingFlexibleRightMargin
                                | UIViewAutoresizingFlexibleTopMargin
                                | UIViewAutoresizingFlexibleHeight
                                | UIViewAutoresizingFlexibleBottomMargin;
    
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

- (void)setImageModel:(AZImageModel *)imageModel {
    if (_imageModel != imageModel) {
        [_imageModel removeObserver:self];
        
        _imageModel = imageModel;
        [_imageModel addObserver:self];
        [imageModel load];
    }
}

#pragma mark -
#pragma mark Image Model Observer

- (void)imageModelDidBecameUnloaded:(AZImageModel *)imageModel {
    self.imageModel = imageModel;
    self.contentImageView.image = imageModel.image;
}

- (void)imageModelDidBecameLoading:(AZImageModel *)imageModel {
    
}

- (void)imageModelDidBecameLoaded:(AZImageModel *)imageModel {
    self.imageModel = imageModel;
    self.contentImageView.image = imageModel.image;
}

- (void)imageModelDidBecameFailedLoading:(AZImageModel *)imageModel {
    [self.imageModel load];
}

@end
