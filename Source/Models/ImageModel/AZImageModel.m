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
#import "AZImageModelCache.h"

static NSString     *kImageURL          = @"kImageURL";
static NSString     *AZImageDirectory   = @"Images";
static double       AZLoadImageDelay    = 1.0;

@interface AZImageModel ()
@property (nonatomic, strong) UIImage   *image;
@property (nonatomic, strong) NSURL     *url;
@property (nonatomic, strong) NSString  *cacheName;

- (NSString *)pathToImages;
- (NSString *)nameOfCashedFile;
- (UIImage *)imageFromCashe;

@end

@implementation AZImageModel

#pragma mark -
#pragma mark Accessors

- (void)dealloc {
    [[AZImageModelCache sharedCache] removeObjectWithURL:self.url];
    
    self.image = nil;
    self.cacheName = nil;
    self.url = nil;
}

- (instancetype)initWithURL:(NSURL *)url {
    AZImageModelCache *cache = [AZImageModelCache sharedCache];
    AZImageModel *model = [cache objectWithURL:url];
    
    if (model) {
        return model;
    }
    
    self = [super init];
    if (self) {
        self.url = url;
        self.cacheName = [self nameOfCachedFile];
    }
    
    [cache addImageModel:self withURL:url];
    
    return self;
}

#pragma mark -
#pragma mark Accessors 

- (void)setUrl:(NSURL *)url {
    if (_url != url) {
        _url = url;
        
        self.cacheName = [self nameOfCachedFile];
    }
}

#pragma mark -
#pragma mark LoadingModel

- (void)performLoading {
    [AZGCD dispatchAfterDelay:AZLoadImageDelay block:^ {
        UIImage *image = [self loadImage];
        self.image = image;
        
        [AZGCD dispatchAsyncOnMainQueue: ^ {
            self.state = image ? AZModelDidLoad : AZModelDidFailLoad;
        }];
    }];
}

#pragma mark -
#pragma mark Private Methods

- (UIImage *)loadImage {
    return [self isCacheExist] ? [self imageFromCache] : [self imageFromURL];
}

- (BOOL)isCacheExist {
    return [NSFileManager.defaultManager fileExistsAtPath:self.cacheName];
}

- (NSString *)pathToImages {
    NSArray *paths = NSSearchPathForDirectoriesInDomains (NSDocumentDirectory, NSUserDomainMask, YES);
    
    return [[paths firstObject] stringByAppendingPathComponent:AZImageDirectory];
}

- (NSString *)nameOfCachedFile {
    NSURL *url = self.url;
    
    NSString *result = [self pathToImages];
    
    result = [result stringByAppendingPathComponent:[NSString stringWithFormat:@"%lu", url.absoluteString.hash]];
    result = [result stringByAppendingString:url.lastPathComponent];
    
    return result;
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

#pragma mark -
#pragma mark NSCoding

- (instancetype)initWithCoder:(NSCoder *)coder {
    NSURL *url = [coder decodeObjectForKey:kImageURL];
    
    return [self initWithURL:url];
}

- (void)encodeWithCoder:(NSCoder *)coder {
    [coder encodeObject:self.url forKey:kImageURL];
}

@end
