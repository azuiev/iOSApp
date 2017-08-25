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

#import "AZInternetImageModel.h"
#import "AZFileSystemImageModel.h"

static NSString     *kImageURL          = @"kImageURL";
static NSString     *AZImageDirectory   = @"Images";
static double       AZLoadImageDelay    = 1.0;

@interface AZImageModel ()
@property (nonatomic, strong) UIImage   *image;

- (NSString *)pathToImages;
- (NSString *)nameOfCashedFile;
- (UIImage *)imageFromCashe;

@end

@implementation AZImageModel

#pragma mark -
#pragma mark Class methods

+ (instancetype)imageWithURL:(NSURL *)url {
    if ([url isFileURL]) {
        return [AZFileSystemImageModel imageWithURL:url];
    } else {
        return [AZInternetImageModel imageWithURL:url];
    }
    
    return nil;
}

#pragma mark -
#pragma mark Initialization and Deallocation

- (void)dealloc {
    [[AZImageModelCache sharedCache] removeObjectWithURL:self.url];
    
    self.image = nil;
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
    }
    
    [cache addImageModel:self withURL:url];
    
    return self;
}

#pragma mark -
#pragma mark Public Methods

- (NSString *)pathToImages {
    NSArray *paths = NSSearchPathForDirectoriesInDomains (NSDocumentDirectory, NSUserDomainMask, YES);
    
    return [[paths firstObject] stringByAppendingPathComponent:AZImageDirectory];
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
#pragma mark NSCoding

- (instancetype)initWithCoder:(NSCoder *)coder {
    NSURL *url = [coder decodeObjectForKey:kImageURL];
    
    return [self initWithURL:url];
}

- (void)encodeWithCoder:(NSCoder *)coder {
    [coder encodeObject:self.url forKey:kImageURL];
}

@end
