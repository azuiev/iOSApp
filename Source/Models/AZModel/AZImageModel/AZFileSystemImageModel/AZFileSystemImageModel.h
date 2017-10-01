//
//  AZFileSystemImageModel.h
//  iOSApp
//
//  Created by Aleksey Zuiev on 26/08/2017.
//  Copyright © 2017 Aleksey Zuiev. All rights reserved.
//

#import "AZImageModel.h"

@interface AZFileSystemImageModel : AZImageModel

+ (instancetype)imageModelWithURL:(NSURL *)url;

- (instancetype)initWithURL:(NSURL *)url;

- (NSString *)nameInFileSystem;

@end
