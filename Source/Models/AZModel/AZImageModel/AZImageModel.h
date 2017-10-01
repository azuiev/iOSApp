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

typedef void (^AZCompletionBlock)(UIImage *image, NSError *error);

@interface AZImageModel : AZModel 
@property (nonatomic, strong)   UIImage     *image;
@property (nonatomic, strong)   NSURL       *url;
@property (nonatomic, readonly) NSString    *imagePath;

+ (instancetype)imageModelWithURL:(NSURL *)url;

- (instancetype)initWithURL:(NSURL *)url;

//Methods for children purposes. Do not call this methods directly
- (void)loadImageWithCompletionHandler:(AZCompletionBlock)CompletionHandler;
- (void)cancel;

@end
