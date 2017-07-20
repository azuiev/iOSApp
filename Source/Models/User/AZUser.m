//
//  AZUser.m
//  iOSApp
//
//  Created by Aleksey Zuiev on 14/07/2017.
//  Copyright © 2017 Aleksey Zuiev. All rights reserved.
//

#import "AZUser.h"

#import "NSString+AZRandomName.h"

@implementation AZUser

@dynamic fullName;
@dynamic imageModel;

#pragma mark -
#pragma mark Initialization and Deallocation

- (instancetype)init {
    self = [super init];
    if (self) {
        self.name = [NSString randomName];
        self.surName = [NSString randomName];
    }
    
    return self;
}

#pragma mark -
#pragma mark Accessors

- (NSString *)fullName {
    return [NSString stringWithFormat:@"%@ %@", self.name, self.surName];
}

- (AZImageModel *)imageModel {
    NSURL *url = [[NSBundle mainBundle ]URLForResource:@"Image" withExtension:@"jpg"];
    return [AZImageModel imageWithUrl:url];
}

@end
