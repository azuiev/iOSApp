//
//  NSFileManager+AZExtension.h
//  iOSApp
//
//  Created by Aleksey Zuiev on 11/10/2017.
//  Copyright © 2017 Aleksey Zuiev. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSFileManager (AZExtension)

- (BOOL)moveItemAtURL:(NSURL *)sourceURL toURL:(NSURL *)destinationURL;
- (BOOL)saveItemFromURL:(NSURL *)sourceURL toURL:(NSURL *)destinationURL;

@end
