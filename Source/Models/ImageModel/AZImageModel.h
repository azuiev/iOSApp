//
//  AZImageModel.h
//  iOSApp
//
//  Created by Aleksey Zuiev on 16/07/2017.
//  Copyright © 2017 Aleksey Zuiev. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "AZModel.h"

@class AZFileSystemImageModel;
@class AZInternetImageModel;

@interface AZImageModel : AZModel 
@property (nonatomic, readonly) UIImage     *image;
@property (nonatomic, strong) NSURL       *url;

+ (instancetype)imageWithURL:(NSURL *)url;

- (instancetype)initWithURL:(NSURL *)url;

- (NSString *)pathToImages;

//Method for children purposes. Do not call this method directly
- (UIImage *)loadImage;

@end
