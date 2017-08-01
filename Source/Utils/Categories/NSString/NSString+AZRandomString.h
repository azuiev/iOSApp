//
//  NSString+AZRandomString.h
//  idap
//
//  Created by Aleksey Zuiev on 09/05/2017.
//  Copyright © 2017 Aleksey Zuiev. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (AZRandomString)

+ (instancetype)lowercaseString;
+ (instancetype)uppercaseString;
+ (instancetype)numericString;
+ (instancetype)alphanumericString;
+ (instancetype)letterString;

+ (instancetype)lowercaseStringWithLength:(NSUInteger)length;
+ (instancetype)uppercaseStringWithLength:(NSUInteger)length;
+ (instancetype)numericStringWithLength:(NSUInteger)length;
+ (instancetype)alphanumericStringWithLength:(NSUInteger)length;
+ (instancetype)letterStringWithLength:(NSUInteger)length;

+ (instancetype)lowercaseStringWithLengthInRange:(NSRange)range;
+ (instancetype)uppercaseStringWithLengthInRange:(NSRange)range;
+ (instancetype)numericStringWithLengthInRange:(NSRange)range;
+ (instancetype)alphanumericStringWithLengthInRange:(NSRange)range;
+ (instancetype)letterStringWithLengthInRange:(NSRange)range;

+ (instancetype)stringFromAlphabet:(NSString *)alphabet;
+ (instancetype)stringFromAlphabet:(NSString *)alphabet length:(NSUInteger)length;
+ (instancetype)stringFromAlphabet:(NSString *)alphabet lengthInRange:(NSRange)length;

+ (instancetype)stringFromRange:(NSRange)range;
+ (instancetype)stringFromRange:(NSRange)range length:(NSUInteger)length;
+ (instancetype)stringFromRange:(NSRange)range lengthInRange:(NSRange)length;

+ (instancetype)stringFromArray:(NSArray *)array;
+ (instancetype)stringFromArray:(NSArray *)array length:(NSUInteger)length;
+ (instancetype)stringFromArray:(NSArray *)array lengthInRange:(NSRange)length;

- (NSArray *)symbols;
@end
