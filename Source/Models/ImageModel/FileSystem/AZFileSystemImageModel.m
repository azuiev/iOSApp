//
//  AZFileSystemImageModel.m
//  iOSApp
//
//  Created by Aleksey Zuiev on 26/08/2017.
//  Copyright © 2017 Aleksey Zuiev. All rights reserved.
//

#import "AZFileSystemImageModel.h"

@implementation AZFileSystemImageModel

- (UIImage *)loadImage {
    NSString *cacheFileName = [self nameInFileSystem];
    
    if ([NSFileManager.defaultManager fileExistsAtPath:cacheFileName]) {
        UIImage *image = [UIImage imageNamed:cacheFileName];
        
        if (!image) {
            NSError *error = nil;
            [NSFileManager.defaultManager removeItemAtPath:cacheFileName error:&error];
        }
        
        return image;
    }
    
    return nil;
}

- (NSString *)nameInFileSystem {
    //TODO categorie
    NSString *name = [self.url.path stringByReplacingOccurrencesOfString:@"/" withString:@""];
    
    return [[self pathToImages] stringByAppendingPathComponent:name];
}

@end
