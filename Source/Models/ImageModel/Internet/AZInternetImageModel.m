//
//  AZInternetImageModel.m
//  iOSApp
//
//  Created by Aleksey Zuiev on 26/08/2017.
//  Copyright © 2017 Aleksey Zuiev. All rights reserved.
//

#import "AZInternetImageModel.h"

@interface AZInternetImageModel ()
@property (nonatomic, strong) NSString  *cacheName;

@end

@implementation AZInternetImageModel

#pragma mark -
#pragma mark Class methods

+ (instancetype)imageWithURL:(NSURL *)url {
    return [[self alloc] initWithURL:url];
}

#pragma mark -
#pragma mark Initialization and Deallocation

- (void)dealloc {
    self.cacheName = nil;
}

#pragma mark -
#pragma mark Accessors

- (void)setUrl:(NSURL *)url {
    [super setUrl:url];
        
    self.cacheName = [self nameOfCachedFile];
}

#pragma mark -
#pragma mark Private methods 

- (NSString *)nameOfCachedFile {
    NSURL *url = self.url;
    
    NSString *result = [self pathToImages];
    NSString *fullPath = url.absoluteString;
    
    result = [result stringByAppendingPathComponent:[NSString stringWithFormat:@"%lu", fullPath.hash]];
    NSLog(@"%lu", (unsigned long)fullPath.hash);
    
    result = [result stringByAppendingString:url.lastPathComponent];
    
    return result;
}

- (UIImage *)loadImage {
    return [self isCacheExist] ? [self imageFromCache] : [self imageFromURL];
}

- (BOOL)isCacheExist {
    return [NSFileManager.defaultManager fileExistsAtPath:self.cacheName];
}

- (UIImage *)imageFromCache {
    NSString *cacheName = self.cacheName;
    UIImage *image = [UIImage imageNamed:cacheName];
    
    if (!image) {
        NSError *error = nil;
        [NSFileManager.defaultManager removeItemAtPath:cacheName error:&error];
        image = [self imageFromURL];
    }
    
    return image;
}

- (UIImage *)imageFromURL {
    NSData *imageData = [NSData dataWithContentsOfURL:self.url];
    
    [self createCacheFile:imageData];
    
    return [UIImage imageWithData:imageData];
}

- (void)createCacheFile:(NSData *)imageData {
    NSString *path = [self pathToImages];
    NSFileManager *manager = NSFileManager.defaultManager;
    NSError *error = nil;
    
    if (![manager fileExistsAtPath:path]) {
        [manager createDirectoryAtPath:[self pathToImages]
           withIntermediateDirectories:YES
                            attributes:nil
                                 error:&error];
    }
    
    if (!error) {
        BOOL saved = [imageData writeToFile:[self nameOfCachedFile] atomically:YES];
        if (!saved) {
            NSLog(@"Unable to save cached image");
        }
    }
}

@end
