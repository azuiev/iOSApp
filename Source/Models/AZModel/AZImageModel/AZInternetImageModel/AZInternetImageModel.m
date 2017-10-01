//
//  AZInternetImageModel.m
//  iOSApp
//
//  Created by Aleksey Zuiev on 26/08/2017.
//  Copyright © 2017 Aleksey Zuiev. All rights reserved.
//

#import "AZInternetImageModel.h"

#import "AZMacros.h"
#import "AZGCD.h"

@interface AZInternetImageModel ()
@property (nonatomic, strong) NSString                  *cacheName;
@property (nonatomic, strong) NSURLSessionDownloadTask  *downloadTask;

@end

@implementation AZInternetImageModel

#pragma mark -
#pragma mark Class methods

+ (instancetype)imageModelWithURL:(NSURL *)url {
    return [[self alloc] initWithURL:url];
}

#pragma mark -
#pragma mark Public Initialization and Deallocation

- (void)dealloc {
    self.downloadTask = nil;
}

#pragma mark -
#pragma mark Accessors

- (void)setDownloadTask:(NSURLSessionDownloadTask *)downloadTask {
    if (_downloadTask == downloadTask) {
        [_downloadTask cancel];
        
        _downloadTask = downloadTask;
    }
}

#pragma mark -
#pragma mark Public methods

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

- (void)loadImageWithCompletionHandler:(AZCompletionBlock)completionBlock {
    [super loadImageWithCompletionHandler:^(UIImage *image, NSError *error) {
        if (image) {
            [AZGCD dispatchAsyncOnMainQueue:^ {
                self.image = image;
                self.state = AZModelDidLoad;
            }];
        };
    }];
    
    if (self.state != AZModelDidLoad) {
        NSURLSession *session = [NSURLSession sharedSession];
        __block UIImage *image = nil;
        NSURLSessionDownloadTask *task = self.downloadTask;
        
        //AZWeakify(completionBlock);
        if (!task) {
            task = [session downloadTaskWithURL:self.url
                              completionHandler:^(NSURL *location, NSURLResponse *response, NSError *error)
                    {
                        //AZStrongify(completionBlock);
                        [self saveTemporaryFile:location];
                        
                        image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[self fileSystemURL]]];
                        if (completionBlock) {
                            completionBlock(image, error);
                        }
                    }];
            self.downloadTask = task;
        }
        
        [task resume];
    }
}

#pragma mark -
#pragma mark Private methods

- (void)saveTemporaryFile:(NSURL *)location {
    if (!location) {
        return;
    }
    
    NSString *path = [self imagePath];
    NSFileManager *manager = NSFileManager.defaultManager;
    NSError *error = nil;
    
    if (![manager fileExistsAtPath:path]) {
        [manager createDirectoryAtPath:path
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
