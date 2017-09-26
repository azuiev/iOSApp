//
//  NSString+AZExtension.m
//  iOSApp
//
//  Created by Aleksey Zuiev on 25/09/2017.
//  Copyright © 2017 Aleksey Zuiev. All rights reserved.
//

#import "NSString+AZExtension.h"
#import "AZRange.h"

@implementation NSString (AZExtension)

+ (NSString *)removeIllegalSymbols:(NSString *)string {
    NSCharacterSet* illegalFileNameCharacters = [NSCharacterSet characterSetWithCharactersInString:@"/\\?%*|\"<>"];
    
    return [[string componentsSeparatedByCharactersInSet:illegalFileNameCharacters] componentsJoinedByString:@""];
}

+ (NSString *)removeMultipleSpaces:(NSString *)string {
    NSError *error = nil;
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"  +" options:NSRegularExpressionCaseInsensitive error:&error];
    
    return [regex stringByReplacingMatchesInString:string
                                           options:0
                                             range:AZMakeRange(0, string.length - 1)
                                      withTemplate:@" "];
}

@end
