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

static NSString     *kImageURL          = @"kImageURL";
static double       AZLoadImageDelay    = 1.0;
static NSString     *AZImageDirectory   = @"Images";

@interface AZImageModel ()
@property (nonatomic, strong) UIImage   *image;
@property (nonatomic, strong) NSURL     *url;
@property (nonatomic, strong) NSString  *casheName;

- (NSString *)pathToImages;
- (NSString *)nameOfCashedFile;
- (UIImage *)imageFromCashe;

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
#pragma mark Accessors 

- (void)setUrl:(NSURL *)url {
    if (_url != url) {
        _url = url;
        
        self.casheName = [self nameOfCashedFile];
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
    return [self isCasheExist] ? [self imageFromCashe] : [self imageFromURL];
}

- (BOOL)isCasheExist {
    return [NSFileManager.defaultManager fileExistsAtPath:self.casheName];
}

- (NSString *)pathToImages {
    NSArray *paths = NSSearchPathForDirectoriesInDomains (NSDocumentDirectory, NSUserDomainMask, YES);
    
    return [[paths firstObject] stringByAppendingPathComponent:AZImageDirectory];
}

- (NSString *)nameOfCashedFile {
    NSURL *url = self.url;
    
    NSString *result = [self pathToImages];
    
    result = [result stringByAppendingPathComponent:[NSString stringWithFormat:@"%lu", url.absoluteString.hash]];
    result = [result stringByAppendingString:url.lastPathComponent];
    
    return result;
}

- (UIImage *)imageFromCashe {
    NSString *casheName = self.casheName;
    UIImage *image = [UIImage imageNamed:casheName];
   
    if (!image) {
        NSError *error = nil;
        [NSFileManager.defaultManager removeItemAtPath:casheName error:&error];
        image = [self imageFromURL];
    }
    
    return image;
}

- (UIImage *)imageFromURL {
    NSData *imageData = [NSData dataWithContentsOfURL:self.url];
    
    [self createCasheFile:imageData];
    
    return [UIImage imageWithData:imageData];
}

- (void)createCasheFile:(NSData *)imageData {
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
        BOOL saved = [imageData writeToFile:[self nameOfCashedFile] atomically:YES];
        if (!saved) {
            NSLog(@"Unable to save cashed image");
        }
    }
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
