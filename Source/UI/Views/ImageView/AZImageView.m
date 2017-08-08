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

- (void)setImageModel:(AZImageModel *)imageModel {
    if (_imageModel != imageModel) {
        [_imageModel dump];
        [_imageModel removeObserver:self];
        
        _imageModel = imageModel;
        [_imageModel addObserver:self];
        
        AZWeakify(self);
        [AZGCD dispatchAfterDelay:AZImageLoadDelay block:^{
            AZStrongifyAndReturnIfNil(self);
            if (self.imageModel == imageModel) {
                [imageModel load];
            }
        }];
    }
}

#pragma mark -
#pragma mark Public Methods

- (void)modelDidLoad:(AZImageModel *)model {
    AZWeakify(self);
    void(^block)(void) = ^{
        AZStrongify(self);
        self.imageModel = model;
        self.contentImageView.image = model.image;
    };
    
    if ([NSThread isMainThread]){
        block();
    } else {
        [AZGCD dispatchSyncOnMainQueue:block];
    }
}

#pragma mark -
#pragma mark Loading Model Observer

- (void)modelDidBecameUnloaded:(AZImageModel *)model {
    [self loadImageFromImageModel:model];
}

- (void)modelDidBecameLoading:(AZImageModel *)model {
    
}

- (void)modelDidBecameLoaded:(AZImageModel *)model {
    [self loadImageFromImageModel:(AZImageModel *)model];
}

- (void)modelDidBecameFailedLoading:(AZImageModel *)model {
    [self.imageModel load];
}

#pragma mark -
#pragma mark Private

- (void)loadImageFromImageModel:(AZImageModel *)imageModel {
    [self modelDidLoad:imageModel];
}

@end
