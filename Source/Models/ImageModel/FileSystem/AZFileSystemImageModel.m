//
//  AZFileSystemImageModel.m
//  iOSApp
//
//  Created by Aleksey Zuiev on 26/08/2017.
//  Copyright © 2017 Aleksey Zuiev. All rights reserved.
//

#import "AZFileSystemImageModel.h"

#import "NSString+AZExtension.h"

@implementation AZFileSystemImageModel

- (void)loadImageWithBlock:(AZCompletionBlock)block {
    NSString *cacheFileName = [self nameInFileSystem];
    UIImage *image = nil;
    NSError *error = nil;
    
    if ([NSFileManager.defaultManager fileExistsAtPath:cacheFileName]) {
        image = [UIImage imageNamed:cacheFileName];
        
        if (!image) {
            [NSFileManager.defaultManager removeItemAtPath:cacheFileName error:&error];
        }
    }
    
    block(image, error);
}

- (NSString *)nameInFileSystem {
    NSString *name = [NSString removeIllegalSymbols:self.url.path];
    
    return [[self imagePath] stringByAppendingPathComponent:name];
}

@end
