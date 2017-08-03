//
//  AZUser.m
//  iOSApp
//
//  Created by Aleksey Zuiev on 14/07/2017.
//  Copyright © 2017 Aleksey Zuiev. All rights reserved.
//

#import "AZUser.h"

#import "NSString+AZRandomName.h"

static NSString   *kName        = @"kName";
static NSString   *kSurName     = @"kSurName";

@interface AZUser ()
@property (nonatomic, strong) NSURL *imageURL;

@end

@implementation AZUser

@dynamic fullName;
@dynamic imageModel;
@dynamic imageURL;

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
    return [AZImageModel imageWithUrl:[self imageURL]];
}

- (NSURL *)imageURL {
    return [[NSBundle mainBundle ] URLForResource:@"Image" withExtension:@"jpg"];
}

#pragma mark -
#pragma mark NSCoding

- (instancetype)initWithCoder:(NSCoder *)coder {
    self = [super init];
    if (self) {
        self.name = [coder decodeObjectForKey:kName];
        self.surName = [coder decodeObjectForKey:kSurName];
    }
    
    return self;
}

- (void)encodeWithCoder:(NSCoder *)coder {
    [coder encodeObject:self.name forKey:kName];
    [coder encodeObject:self.surName forKey:kSurName];
}

@end
