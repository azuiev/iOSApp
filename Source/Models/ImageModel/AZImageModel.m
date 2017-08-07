//
//  AZImageModel.m
//  iOSApp
//
//  Created by Aleksey Zuiev on 16/07/2017.
//  Copyright © 2017 Aleksey Zuiev. All rights reserved.
//

#import "AZImageModel.h"

#import "AZMacros.h"

@interface AZImageModel ()
@property (nonatomic, strong) UIImage  *image;
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
    self.image = [UIImage imageNamed:self.imageName];
}

@end
