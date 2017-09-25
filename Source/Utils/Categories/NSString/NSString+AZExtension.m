//
//  NSString+AZExtension.m
//  iOSApp
//
//  Created by Aleksey Zuiev on 25/09/2017.
//  Copyright © 2017 Aleksey Zuiev. All rights reserved.
//

#import "NSString+AZExtension.h"

@implementation NSString (AZExtension)

+ (NSString *)removeIllegalSymbols:(NSString *)string {
    NSCharacterSet* illegalFileNameCharacters = [NSCharacterSet characterSetWithCharactersInString:@"/\\?%*|\"<>"];
    
    return [[string componentsSeparatedByCharactersInSet:illegalFileNameCharacters] componentsJoinedByString:@""];
}

@end
