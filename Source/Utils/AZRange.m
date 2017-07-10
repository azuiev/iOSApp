//
//  AZRange.m
//  iOSApp
//
//  Created by Aleksey Zuiev on 11/07/2017.
//  Copyright © 2017 Aleksey Zuiev. All rights reserved.
//

#import "AZRange.h"

NSRange AZMakeRange(NSUInteger min, NSUInteger max) {
    return NSMakeRange(min, max - min + 1);
}
