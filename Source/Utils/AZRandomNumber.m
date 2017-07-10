//
//  AZRandomNumber.m
//  idap
//
//  Created by Aleksey Zuiev on 15/05/2017.
//  Copyright © 2017 Aleksey Zuiev. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "AZRandomNumber.h"

#import "AZRange.h"

NSUInteger AZRandomNumberInRange(NSRange range) {
    return range.location + arc4random_uniform((uint32_t)(range.length));
}

NSUInteger AZRandomNumberWithMaxValue(NSUInteger maxValue) {
    return AZRandomNumberInRange(AZMakeRange(0, maxValue));
}
