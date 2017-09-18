//
//  AZFBUsersModel.m
//  iOSApp
//
//  Created by Aleksey Zuiev on 11/09/2017.
//  Copyright © 2017 Aleksey Zuiev. All rights reserved.
//

#import "AZFBUsersModel.h"
#import "AZFBUserModel.h"

#import "NSArray+AZExtension.h"

@interface AZFBUsersModel ()
@property (nonatomic, strong) NSString  *mutablePlistName;

@end

@implementation AZFBUsersModel

@dynamic plistName;

- (NSString *)plistName {
    return self.mutablePlistName;
}

#pragma mark -
#pragma mark LoadingModel

- (void)performLoading {
    NSArray *array = [NSKeyedUnarchiver unarchiveObjectWithFile:[self plistName]];
    
//    if (!array) {
//        array = [NSArray objectsWithCount:10 block:^ {
//            return [AZFBUserModel new];
//        }];
//    }
    
    [self addObjects:array];
    self.state = array ? AZModelDidLoad : AZModelDidFailLoad;
}

- (void)initPlist {
    self.mutablePlistName = @"fbfriends.plist";
}

@end
