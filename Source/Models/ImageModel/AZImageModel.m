//
//  AZImageModel.m
//  iOSApp
//
//  Created by Aleksey Zuiev on 16/07/2017.
//  Copyright © 2017 Aleksey Zuiev. All rights reserved.
//

#import "AZImageModel.h"

@interface AZImageModel ()
@property (nonatomic, strong) UIImage   *image;
@property (nonatomic, strong) NSURL     *url;

@end
@implementation AZImageModel

#pragma mark -
#pragma mark Class methods

+ (instancetype)imageWithUrl:(NSURL *)url {
    return [[self alloc] initWithURL:url];
}

#pragma mark -
#pragma mark Initialization and Deallocation

- (instancetype)initWithURL:(NSURL *)url {
    self = [super init];
    if (self) {
        self.url = url;
    }
    
    return self;
}

#pragma mark -
#pragma mark Accessors

- (BOOL)isLoaded {
    return nil != self.image;
}

#pragma mark -
#pragma mark Public methods

- (void)load {
    if (!self.isLoaded) {
        return;
    }
}

- (void)dump {
    self.image = nil;
}

@end
