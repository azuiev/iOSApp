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
@property (nonatomic, strong) NSURLSessionDownloadTask *downloadTask;

@end

@implementation AZInternetImageModel

#pragma mark -
#pragma mark Class methods

+ (instancetype)imageModelWithURL:(NSURL *)url {
    return [[self alloc] initWithURL:url];
}

#pragma mark -
#pragma mark Public methods

- (UIImage *)loadImage {
    UIImage *image = [super loadImage];
    
    if (image) {
        return image;
    }
    
    return [self performLoadingWithBlock:nil];
}

- (void)cancel {
    NSURLSessionDownloadTask *downloadTask = self.downloadTask;
    switch (downloadTask.state) {
        case NSURLSessionTaskStateRunning || NSURLSessionTaskStateSuspended:
            [downloadTask cancel];
            break;
            
        default:
            self.image = nil;
            break;
    }
}

#pragma mark -
#pragma mark Private methods

- (UIImage *)performLoadingWithBlock:(void(^)(NSURL *location, NSURLResponse *response, NSError *error))block {
    NSURLSession *session = [NSURLSession sharedSession];
    __block UIImage *image = nil;
    NSURLSessionDownloadTask *task = self.downloadTask;
    if (!task) {
        task = [session downloadTaskWithURL:self.url
                          completionHandler:^(NSURL *location, NSURLResponse *response, NSError *error)
                {
                    [self saveTemporaryFile:location];
                    if (block) {
                        block(location, response, error);
                    }
                    
                    image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[self fileSystemURL]]];
                }];
    }
    
    if (task.state == NSURLSessionTaskStateSuspended) {
        [task resume];
    }
    
    return image;
}

- (void)saveTemporaryFile:(NSURL *)location {
    if (!location) {
        return;
    }
    
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
        NSURL *url = [self fileSystemURL];
        BOOL saved = [manager copyItemAtURL:location toURL:url error:&error];
        if (!saved) {
            NSLog(@"Unable to save image to filesystem");
        } else {
            NSLog(@"saved !!!");
        }
    }
}

- (NSURL *)fileSystemURL {
    return [NSURL fileURLWithPath:[self nameInFileSystem]];
}

@end
