//
//  AZUsersModel.m
//  iOSApp
//
//  Created by Aleksey Zuiev on 16/08/2017.
//  Copyright © 2017 Aleksey Zuiev. All rights reserved.
//

#import "AZUsersModel.h"

static NSString *AZPlistName = @"users.plist";

@implementation AZUsersModel

#pragma mark -
#pragma mark LoadingModel

- (void)performLoading {
    NSArray *array = [NSKeyedUnarchiver unarchiveObjectWithFile:[self plistName]];
    [self addObjects:array];
    self.state = array ? AZModelDidLoad : AZModelDidFailLoad;
}

- (void)save {
    [NSKeyedArchiver archiveRootObject:self.array toFile:[self plistName]];
}

#pragma mark -
#pragma mark Private

- (NSString *)plistName {
    NSArray *paths = NSSearchPathForDirectoriesInDomains (NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *result = [paths firstObject];
    
    result = [result stringByAppendingPathComponent:AZPlistName];
    
    return result;
}

@end
