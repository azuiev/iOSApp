//
//  AZFBUserModel.m
//  iOSApp
//
//  Created by Aleksey Zuiev on 11/09/2017.
//  Copyright © 2017 Aleksey Zuiev. All rights reserved.
//

#import "AZFBUserModel.h"

@interface AZFBUserModel ()
@property (nonatomic, strong) NSString *userID;

@end

@implementation AZFBUserModel

#pragma mark -
#pragma mark Class methods

+ (instancetype)userWithID:(NSString *)userID fullName:(NSString *)fullName url:(NSURL *)url {
    return [[self alloc] initWithID:(NSString *)userID fullName:(NSString *)fullName url:(NSURL *)url];
}

#pragma mark -
#pragma mark Initialization

- (instancetype)initWithID:(NSString *)userID fullName:(NSString *)fullName url:(NSURL *)url {
    NSArray *strings = [fullName componentsSeparatedByString:@" "];
    NSString *name = strings[0];
    NSString *surname = strings[1];
    AZImageModel *imageModel = [AZImageModel imageModelWithURL:url];
    
    self = [super initUserModelWithName:name surname:surname imageModel:imageModel];
    if (self) {
        self.userID = userID;
    }
    
    return self;
}

@end
