//
//  AZUsersModel.m
//  iOSApp
//
//  Created by Aleksey Zuiev on 16/08/2017.
//  Copyright © 2017 Aleksey Zuiev. All rights reserved.
//

#import "AZUsersModel.h"

#import "AZUserModel.h"

#import "NSArray+AZExtension.h"

static NSString *AZPlistName = @"users.plist";

@implementation AZUsersModel

#pragma mark -
#pragma mark Initialization and deallocation

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (instancetype)init {
    self = [super init];
    if (self) {
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(save)
                                                     name:@"AZSaveNotification"
                                                   object:nil];
        
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(load)
                                                     name:@"AZLoadNotification"
                                                   object:nil];
    }
    
    return self;
}

#pragma mark -
#pragma mark LoadingModel

- (void)performLoading {
    NSArray *array = [NSKeyedUnarchiver unarchiveObjectWithFile:[self plistName]];

    if (!array) {
        array = [NSArray objectsWithCount:10 block:^ {
            return [AZUserModel new];
        }];
    }
    
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
