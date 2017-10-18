//
//  NSFileManager+AZExtension.m
//  iOSApp
//
//  Created by Aleksey Zuiev on 11/10/2017.
//  Copyright © 2017 Aleksey Zuiev. All rights reserved.
//

#import "NSFileManager+AZExtension.h"
#import "AZMacros.h"

typedef BOOL (^AZFileManagerBlock)(NSURL *sourceURL, NSURL *destinationURL, NSError *error);

@interface NSFileManager (AZExtension)

- (BOOL)checkSourceURL:(NSURL *)url;
- (BOOL)checkDestinationURL:(NSURL *)url;

@end

@implementation NSFileManager (AZExtension)

#pragma mark -
#pragma mark Public Methods

- (BOOL)moveItemAtURL:(NSURL *)sourceURL toURL:(NSURL *)destinationURL {
    AZWeakify(self);
    
    return [self performOperationWithSourceURL:sourceURL
                               destinationURL:destinationURL
                                        block:^BOOL(NSURL *url1, NSURL *url2, NSError *error) {
                                            AZStrongify(self);
                                            
                                            return [self moveItemAtURL:url1 toURL:url2 error:&error];
                                        }];

}

- (BOOL)saveItemFromURL:(NSURL *)sourceURL toURL:(NSURL *)destinationURL {
    AZWeakify(self);
    
    return [self performOperationWithSourceURL:sourceURL
                                destinationURL:destinationURL
                                         block:^BOOL(NSURL *url1, NSURL *url2, NSError *error) {
                                             AZStrongify(self);
                                             
                                             return [self copyItemAtURL:url1 toURL:url2 error:&error];
                                         }];
}

#pragma mark -
#pragma mark Private Methods

- (BOOL)performOperationWithSourceURL:(NSURL *)sourceURL
                       destinationURL:(NSURL *)destinationURL
                                block:(AZFileManagerBlock)block
{
    if (![self checkSourceURL:sourceURL]
        || ![self checkDestinationURL:destinationURL]
        || !block)
    {
        return NO;
    }

    NSError *error = nil;
    
    BOOL result = block(sourceURL, destinationURL, error);
    if (!result) {
        NSLog(@"%@", error);
    }
    
    return result;
}

- (BOOL)checkSourceURL:(NSURL *)url {
    NSString *sourcePath = url.path;
    if (![self fileExistsAtPath:sourcePath]) {
        NSLog(@"Source file does not found at path %@", sourcePath);
        
        return NO;
    };
    
    return YES;
}

- (BOOL)checkDestinationURL:(NSURL *)url {
    NSString *path = [[url URLByDeletingLastPathComponent] path];
    
    if (!url.isFileURL) {
        NSLog(@"Destination file is not in filesystem");
        
        return NO;
    }
    
    NSError *error = nil;
    if (![self fileExistsAtPath:path]) {
        BOOL createDirectory = [self createDirectoryAtPath:path
                               withIntermediateDirectories:YES
                                                attributes:nil
                                                     error:&error];
        if (!createDirectory) {
            NSLog(@"Unable to create directory %@ - %@", path, error);
            
            return NO;
        }
    }
    
    return YES;
}

@end
