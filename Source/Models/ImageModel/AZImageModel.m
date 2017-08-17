//
//  AZImageModel.m
//  iOSApp
//
//  Created by Aleksey Zuiev on 16/07/2017.
//  Copyright © 2017 Aleksey Zuiev. All rights reserved.
//

#import "AZImageModel.h"

#import "AZGCD.h"
#import "AZMacros.h"

static NSString   *kImageURL        = @"kImageURL";

@interface AZImageModel ()
@property (nonatomic, strong) UIImage   *image;
@property (nonatomic, strong) NSURL     *url;

- (NSString *)pathToImages;
- (NSString *)nameOfCasheFileWithURL:(NSURL *)url;

@end

@implementation AZImageModel

- (instancetype)initWithURL:(NSURL *)url {
    self = [super init];
    if (self) {
        self.url = url;
    }
    
    return self;
}

#pragma mark -
#pragma mark LoadingModel

- (void)performLoading {
    [AZGCD dispatchAfterDelay:1.0 block:^ {
        UIImage *image = nil;
        NSString *cashedFileName = [self nameOfCasheFileWithURL:self.url];
        
        if ([[NSFileManager defaultManager] fileExistsAtPath:cashedFileName]) {
            image = [UIImage imageNamed:cashedFileName];
        } else {
            NSData *imageData = [NSData dataWithContentsOfURL:self.url];
            [[NSFileManager defaultManager] createDirectoryAtPath:[self pathToImages]
                                      withIntermediateDirectories:YES
                                                       attributes:nil
                                                            error:nil];
            BOOL saved = [imageData writeToFile:cashedFileName atomically:YES];
            if (!saved) {
                NSLog(@"Achtung!!!");
            }
            
            image = [UIImage imageWithData:imageData];
        }
        
        
        self.image = image;
        
        [AZGCD dispatchAsyncOnMainQueue: ^ {
            self.state = image ? AZModelDidLoad : AZModelDidFailLoad;
        }];
    }];
}

#pragma mark -
#pragma mark Private Methods

- (NSString *)pathToImages {
    NSArray *paths = NSSearchPathForDirectoriesInDomains (NSDocumentDirectory, NSUserDomainMask, YES);
    return [[paths firstObject] stringByAppendingPathComponent:@"Images"];
}

- (NSString *)nameOfCasheFileWithURL:(NSURL *)url {
    NSString *result = [self pathToImages];
    result = [result stringByAppendingPathComponent:[NSString stringWithFormat:@"%lu", url.absoluteString.hash]];
    result = [result stringByAppendingString:url.lastPathComponent];
    
    return result;
}

#pragma mark -
#pragma mark NSCoding

- (instancetype)initWithCoder:(NSCoder *)coder {
    self = [super init];
    if (self) {
        self.url = [coder decodeObjectForKey:kImageURL];
    }
    
    return self;
}

- (void)encodeWithCoder:(NSCoder *)coder {
    [coder encodeObject:self.url forKey:kImageURL];
}

@end
