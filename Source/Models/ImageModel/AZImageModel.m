//
//  AZImageModel.m
//  iOSApp
//
//  Created by Aleksey Zuiev on 16/07/2017.
//  Copyright © 2017 Aleksey Zuiev. All rights reserved.
//

#import "AZImageModel.h"

#import "AZMacros.h"

@implementation AZImageModel

#pragma mark -
#pragma mark LoadingModel

- (void)saveToURL:(NSURL *)url {
    
}

- (id)modelWithURL:(NSURL *)url {
    return [UIImage imageWithContentsOfFile:[url path]];
}

@end
