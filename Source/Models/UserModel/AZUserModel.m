//
//  AZUserModel.m
//  iOSApp
//
//  Created by Aleksey Zuiev on 14/07/2017.
//  Copyright © 2017 Aleksey Zuiev. All rights reserved.
//

#import "AZUserModel.h"

#import "NSString+AZRandomName.h"

static NSString   *kName        = @"kName";
static NSString   *kSurName     = @"kSurName";
static NSString   *kImageModel  = @"kImageModel";

static NSString *urlName    = @"https://upload.wikimedia.org/wikipedia/en/c/c6/NeoTheMatrix.jpg";

@interface AZUserModel ()
@property (nonatomic, strong) AZImageModel  *imageModel;

@end

@implementation AZUserModel

@dynamic fullName;

#pragma mark -
#pragma mark Initialization and Deallocation

- (instancetype)init {
    self = [super init];
    if (self) {
        self.name = [NSString randomName];
        self.surName = [NSString randomName];
        self.imageModel = [[AZImageModel alloc] initWithURL:[NSURL URLWithString:urlName]];
    }
    
    return self;
}

#pragma mark -
#pragma mark Accessors

- (NSString *)fullName {
    return [NSString stringWithFormat:@"%@ %@", self.name, self.surName];
}

#pragma mark -
#pragma mark NSCoding

- (instancetype)initWithCoder:(NSCoder *)coder {
    self = [super init];
    if (self) {
        self.name = [coder decodeObjectForKey:kName];
        self.surName = [coder decodeObjectForKey:kSurName];
        self.imageModel = [coder decodeObjectForKey:kImageModel];
    }
    
    return self;
}

- (void)encodeWithCoder:(NSCoder *)coder {
    [coder encodeObject:self.name forKey:kName];
    [coder encodeObject:self.surName forKey:kSurName];
    [coder encodeObject:self.imageModel forKey:kImageModel];
}

@end
