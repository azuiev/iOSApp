//
//  NSFileManager+AZExtension.m
//  iOSApp
//
//  Created by Aleksey Zuiev on 11/10/2017.
//  Copyright © 2017 Aleksey Zuiev. All rights reserved.
//

#import "NSFileManager+AZExtension.h"

@implementation NSFileManager (AZExtension)

- (BOOL)moveItemAtURL:(NSURL *)sourceURL toURL:(NSURL *)destinationURL {
    if (!sourceURL || !destinationURL) {
        return NO;
    }
    
    NSString *sourcePath = sourceURL.path;
    NSString *destinationFolderPath = [[destinationURL URLByDeletingLastPathComponent] path];
    
    if (![self fileExistsAtPath:sourcePath]) {
        NSLog(@"Source file does not found at path %@", sourcePath);
        
        return NO;
    };
    
    if (!destinationFolderPath) {
        NSLog(@"Destination path is invalid");
        
        return NO;
    }
    
    NSError *error = nil;
    if (![self fileExistsAtPath:destinationFolderPath]) {
        BOOL createDirectory = [self createDirectoryAtPath:destinationFolderPath
                               withIntermediateDirectories:YES
                                                attributes:nil
                                                     error:&error];
        if (!createDirectory) {
            NSLog(@"Unable to create directory %@ - %@", destinationFolderPath, error);
            
            return NO;
        }
    }
    
    BOOL result = [self moveItemAtURL:sourceURL toURL:destinationURL error:&error];
    NSLog(@"%@", error);
    
    return result;
}

@end
