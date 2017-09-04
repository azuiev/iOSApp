//
//  AZInternetImageModel.h
//  iOSApp
//
//  Created by Aleksey Zuiev on 26/08/2017.
//  Copyright © 2017 Aleksey Zuiev. All rights reserved.
//

#import "AZFileSystemImageModel.h"

@interface AZInternetImageModel : AZFileSystemImageModel

+ (instancetype)imageModelWithURL:(NSURL *)url;

- (UIImage *)performLoadingWithBlock:(void(^)(NSURL *location, NSURLResponse *response, NSError *error))block;

@end
