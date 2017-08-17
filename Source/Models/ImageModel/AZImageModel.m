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
        NSData *imageData = [NSData dataWithContentsOfURL:self.url];

        UIImage *image = [UIImage imageWithData:imageData];
        self.image = image;
        
        [AZGCD dispatchAsyncOnMainQueue: ^ {
            self.state = image ? AZModelDidLoad : AZModelDidFailLoad;
        }];
    }];
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
