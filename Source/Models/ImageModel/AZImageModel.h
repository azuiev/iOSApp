//
//  AZImageModel.h
//  iOSApp
//
//  Created by Aleksey Zuiev on 16/07/2017.
//  Copyright © 2017 Aleksey Zuiev. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "AZObservableObject.h"

@interface AZImageModel : AZObservableObject
@property (nonatomic, readonly) UIImage *image;
@property (nonatomic, readonly) NSURL   *url;

@property (nonatomic, readonly, getter=isLoaded) BOOL loaded;

+ (instancetype)imageWithUrl:(NSURL *)url;

- (instancetype)initWithURL:(NSURL *)url;
- (void)load;
- (void)dump;

@end
