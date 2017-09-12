//
//  AZFBLoginContext.h
//  iOSApp
//
//  Created by Aleksey Zuiev on 07/09/2017.
//  Copyright © 2017 Aleksey Zuiev. All rights reserved.
//

#import "AZContext.h"

@interface AZFBLoginContext : AZContext

+ (instancetype)contextWithViewController:(UIViewController *)controller;

- (BOOL)alreadyLogged;

@end
