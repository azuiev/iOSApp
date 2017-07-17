//
//  AZImageModel.h
//  iOSApp
//
//  Created by Aleksey Zuiev on 16/07/2017.
//  Copyright © 2017 Aleksey Zuiev. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "AZObservableObject.h"

@class AZImageModel;

typedef NS_ENUM(NSUInteger, AZImageModelState) {
    AZImageModelUnloaded,
    AZImageModelLoading,
    AZImageModelLoaded,
    AZImageModelFailedLoading
};

@protocol AZImageModelObserver <NSObject>

@optional
- (void)imageModelDidBecameUnloaded:(AZImageModel *)imageModel;
- (void)imageModelDidBecameLoading:(AZImageModel *)imageModel;
- (void)imageModelDidBecameLoaded:(AZImageModel *)imageModel;
- (void)imageModelDidBecameFailedLoading:(AZImageModel *)imageModel;

@end

@interface AZImageModel : AZObservableObject
@property (nonatomic, readonly) UIImage *image;
@property (nonatomic, readonly) NSURL   *url;

+ (instancetype)imageWithUrl:(NSURL *)url;

- (instancetype)initWithURL:(NSURL *)url;
- (void)load;
- (void)dump;

@end
