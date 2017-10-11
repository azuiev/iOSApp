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
    NSString * result = [self.path stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet alphanumericCharacterSet]];
    
    return result;
}

@end
