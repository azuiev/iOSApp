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

+ (instancetype)imageModelWithURL:(NSURL *)url {
    return [[self alloc] initWithURL:url];
}

#pragma mark -
#pragma mark Private methods 

- (UIImage *)loadImage {
    UIImage *image = [super loadImage];
    
    if (image) {
        return image;
    }
    
    return [self imageFromInternet];
}

- (UIImage *)imageFromInternet {
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
        NSString *name = [self nameInFileSystem];
        NSLog(@"%@", name);
        BOOL saved = [imageData writeToFile:name atomically:YES];
        if (!saved) {
            NSLog(@"Unable to save image to filesystem");
        }
    }
}

@end
