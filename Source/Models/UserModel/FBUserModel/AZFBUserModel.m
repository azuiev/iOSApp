//
//  AZFBUserModel.m
//  iOSApp
//
//  Created by Aleksey Zuiev on 11/09/2017.
//  Copyright © 2017 Aleksey Zuiev. All rights reserved.
//

#import "AZFBUserModel.h"

@implementation AZFBUserModel

#pragma mark -
#pragma mark Class methods

+ (instancetype)userWithFullName:(NSString *)fullName url:(NSURL *)url {
    return [[self alloc] initWithFullName:fullName url:url];
}

- (instancetype)initWithFullName:(NSString *)fullName url:(NSURL *)url {
    NSArray *strings = [fullName componentsSeparatedByString:@" "];
    NSString *name = strings[0];
    NSString *surname = strings[1];
    AZImageModel *imageModel = [AZImageModel imageModelWithURL:url];
    //TODO
    return nil;
}

@end
