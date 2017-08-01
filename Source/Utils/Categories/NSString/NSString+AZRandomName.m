//
//  NSString+AZRandomName.m
//  idap
//
//  Created by Aleksey Zuiev on 16/05/2017.
//  Copyright © 2017 Aleksey Zuiev. All rights reserved.
//

#import "NSString+AZRandomName.h"

#import "NSString+AZRandomString.h"

@implementation NSString (AZRandomName)

+ (NSString *)randomName {
    return [[NSString lowercaseString] capitalizedString];
}

+ (NSString *)randomNameWithLength:(NSUInteger)length {
    return [[NSString lowercaseStringWithLength:length] capitalizedString];
}

+ (NSString *)randomNameWithLengthInRange:(NSRange)range {
    return [[NSString lowercaseStringWithLengthInRange:range] capitalizedString];
}

@end
