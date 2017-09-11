//
//  AZUsersModel.m
//  iOSApp
//
//  Created by Aleksey Zuiev on 16/08/2017.
//  Copyright © 2017 Aleksey Zuiev. All rights reserved.
//

#import "AZUsersModel.h"
#import "AZUserModel.h"
#import "AZMacros.h"

#import "NSArray+AZExtension.h"

@interface AZUsersModel ()
@property (nonatomic, strong) NSString  *mutablePlistName;

@end

@implementation AZUsersModel

@dynamic plistName;

#pragma mark -
#pragma mark Initialization and deallocation

- (void)dealloc {
    [self unsubscribeToNotification];
}

- (instancetype)init {
    self = [super init];
    if (self) {
        [self subscribeToNotification];
        [self initPlist];
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

- (NSString *)fullPlistName {
    NSArray *paths = NSSearchPathForDirectoriesInDomains (NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *result = [paths firstObject];
    
    result = [result stringByAppendingPathComponent:self.plistName];
    
    return result;
}

- (NSString *)plistName {
    return self.mutablePlistName;
}

- (void)subscribeToNotification {
    NSArray *notifications = [self notificationList];
    
    AZWeakify(self);
    for (NSString *notification in notifications) {
        [[NSNotificationCenter defaultCenter] addObserverForName:notification
                                                          object:nil
                                                           queue:nil
                                                      usingBlock:^(NSNotification *note) {
                                                          AZStrongify(self);
                                                          NSLog(@"Received the notification!");
                                                          [self save];
                                                      }];
    }
}

- (void)unsubscribeToNotification {
    NSArray *notifications = [self notificationList];
    
    for (NSString *notification in notifications) {
        [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:notification
                                                      object:nil];
    }
}

- (NSArray *)notificationList {
    return @[@"UIApplicationDidEnterBackgroundNotification", @"UIApplicationWillTerminateNotification"];
}

- (void)initPlist {
    self.mutablePlistName = @"users.plist";
}
@end
