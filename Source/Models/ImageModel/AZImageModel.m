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

static NSString   *kImageName        = @"kImageName";

@interface AZImageModel ()
@property (nonatomic, strong) UIImage   *image;
@property (nonatomic, strong) NSString  *imageName;

@end

@implementation AZImageModel

- (instancetype)initWithName:(NSString *)name {
    self = [super init];
    if (self) {
        self.imageName = name;
    }
    
    return self;
}

#pragma mark -
#pragma mark LoadingModel

- (void)performLoading {
    [AZGCD dispatchAfterDelay:1.0 block:^ {
        UIImage * image = [UIImage imageNamed:self.imageName];

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
        self.imageName = [coder decodeObjectForKey:kImageName];
    }
    
    return self;
}

- (void)encodeWithCoder:(NSCoder *)coder {
    [coder encodeObject:self.imageName forKey:kImageName];
}

@end
