//
//  NSURL+AZExtension.m
//  iOSApp
//
//  Created by Aleksey Zuiev on 01/10/2017.
//  Copyright © 2017 Aleksey Zuiev. All rights reserved.
//

#import "NSURL+AZExtension.h"

#import "NSString+AZRandomString.h"

@implementation NSURL (AZExtension)

- (NSString *)pathWithRemovingIllegalSymbols {
    NSCharacterSet *set = [NSCharacterSet characterSetWithCharactersInString:[NSString alphanumericString]];
    
    return [self.path stringByAddingPercentEncodingWithAllowedCharacters:set];
}

@end
