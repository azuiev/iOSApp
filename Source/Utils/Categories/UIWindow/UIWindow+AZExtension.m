//
//  UIWindow+AZExtension.m
//  iOSApp
//
//  Created by Aleksey Zuiev on 26/07/2017.
//  Copyright © 2017 Aleksey Zuiev. All rights reserved.
//

#import "UIWindow+AZExtension.h"

@implementation UIWindow (AZExtension)

+ (instancetype)window {
    return [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
}

@end
