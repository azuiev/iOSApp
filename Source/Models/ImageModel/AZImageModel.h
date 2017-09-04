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
@property (nonatomic, strong) UIImage     *image;
@property (nonatomic, strong) NSURL       *url;

+ (instancetype)imageModelWithURL:(NSURL *)url;

- (instancetype)initWithURL:(NSURL *)url;

- (NSString *)pathToImages;

//Methods for children purposes. Do not call this methods directly
- (UIImage *)loadImage;
- (void)cancel;

@end
