//
//  AZFileSystemImageModel.m
//  iOSApp
//
//  Created by Aleksey Zuiev on 26/08/2017.
//  Copyright © 2017 Aleksey Zuiev. All rights reserved.
//

#import "AZFileSystemImageModel.h"

#import "NSURL+AZExtension.h"
#import "NSString+AZExtension.h"

@implementation AZFileSystemImageModel

#pragma mark -
#pragma mark Class methods

+ (instancetype)imageModelWithURL:(NSURL *)url {
    return [[self alloc] initWithURL:url];
}

#pragma mark -
#pragma mark Public methods

- (void)loadImageWithCompletionHandler:(AZCompletionBlock)completionHandler {
    NSString *cacheFileName = [self nameInFileSystem];
    UIImage *image = nil;
    NSError *error = nil;
    
    if ([NSFileManager.defaultManager fileExistsAtPath:cacheFileName]) {
        image = [UIImage imageNamed:cacheFileName];
        
        if (!image) {
            [NSFileManager.defaultManager removeItemAtPath:cacheFileName error:&error];
        }
    }
    
    completionHandler(image, error);
}

- (NSString *)nameInFileSystem {
    NSString *string = [NSString removeIllegalSymbols:self.url.path];
    NSLog(@"%@", string);
    
    return [[self imagePath] stringByAppendingString:string];
    //return [[self imagePath] stringByAppendingPathComponent:[self.url pathWithRemovingIllegalSymbols]];
}

@end
