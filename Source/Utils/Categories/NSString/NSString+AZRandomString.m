//
//  NSString+AZRandomString.m
//  idap
//
//  Created by Aleksey Zuiev on 09/05/2017.
//  Copyright © 2017 Aleksey Zuiev. All rights reserved.
//

#import "NSString+AZRandomString.h"

#import "AZRandomNumber.h"
#import "AZRange.h"

static const NSUInteger AZDefaultStringLength = 8;

@interface NSString (AZPrivateRandomString)

+ (NSMutableString *)alphabetFromRange:(NSRange)range;
+ (instancetype)alphabetFromArray:(NSArray *)array;

@end

@implementation NSString (AZRandomString)

#pragma mark -
#pragma mark Public

- (NSArray *)symbols {
    NSUInteger length = self.length;
    NSMutableArray *result = [NSMutableArray arrayWithCapacity:length];
    
    for (NSUInteger index = 0; index < length; index += 1) {
        unichar character = [self characterAtIndex:index];
        [result addObject:[NSString stringWithFormat:@"%c", character]];
    }
    
    return [result copy];
}

//string from alphabet
+ (instancetype)stringFromAlphabet:(NSString *)alphabet {
    return [self stringFromAlphabet:alphabet length:AZDefaultStringLength];
}

+ (instancetype)stringFromAlphabet:(NSString *)alphabet length:(NSUInteger)length {
    NSMutableString *result = [NSMutableString string];
    for (u_int i = 0; i < length; i += 1) {
        [result appendFormat:@"%c",[alphabet characterAtIndex:AZRandomNumberWithMaxValue(alphabet.length - 1)]];
    }
    
    return result;
}

+ (instancetype)stringFromAlphabet:(NSString *)alphabet lengthInRange:(NSRange)range {
    return [self stringFromAlphabet:alphabet length:AZRandomNumberInRange(range)];
}

//string from range
+ (instancetype)stringFromRange:(NSRange)range {
    return [self stringFromAlphabet:[self alphabetFromRange:range] length:AZDefaultStringLength];
}

+ (instancetype)stringFromRange:(NSRange)range length:(NSUInteger)length {
    return [self stringFromAlphabet:[self alphabetFromRange:range] length:length];
}

+ (instancetype)stringFromRange:(NSRange)range lengthInRange:(NSRange)length{
    return [self stringFromAlphabet:[self alphabetFromRange:range] length:AZRandomNumberInRange(length)];
}

//string from array
+ (instancetype)stringFromArray:(NSArray *)array {
    return [self stringFromAlphabet:[self alphabetFromArray:array] length:AZDefaultStringLength];
}

+ (instancetype)stringFromArray:(NSArray *)array length:(NSUInteger)length {
    return [self stringFromAlphabet:[self alphabetFromArray:array] length:length];
}

+ (instancetype)stringFromArray:(NSArray *)array lengthInRange:(NSRange)length {
    return [self stringFromAlphabet:[self alphabetFromArray:array] length:AZRandomNumberInRange(length)];
}

#define AZAlphabetMethods(alphabet)  \
+ (instancetype) alphabet ##String { \
return [self stringFromAlphabet:[self alphabet ##Alphabet]]; \
} \
+ (instancetype)alphabet ##StringWithLength:(NSUInteger)length { \
return [self stringFromAlphabet:[self alphabet ##Alphabet] length:length];\
}\
+ (instancetype)alphabet ##StringWithLengthInRange:(NSRange)range { \
return [self stringFromAlphabet:[self alphabet ##Alphabet] lengthInRange:(NSRange)range]; \
} \

AZAlphabetMethods(lowercase);
AZAlphabetMethods(uppercase);
AZAlphabetMethods(numeric);
AZAlphabetMethods(letter);
AZAlphabetMethods(alphanumeric);

#undef AZAlphabetMethods

#pragma mark -
#pragma mark Alphabet Methods

+ (instancetype)lowercaseAlphabet {
    return [self alphabetFromRange:AZMakeRange('a', 'z')];
}

+ (instancetype)uppercaseAlphabet {
    return [self alphabetFromRange:AZMakeRange('A', 'Z')];
}

+ (instancetype)numericAlphabet {
    return [self alphabetFromRange:AZMakeRange('0', '9')];
}

+ (instancetype)letterAlphabet {
    return [[self lowercaseAlphabet] stringByAppendingString:[self uppercaseAlphabet]];;
}

+ (instancetype)alphanumericAlphabet {
    return [[self letterAlphabet] stringByAppendingString:[self numericAlphabet]];
}

#pragma mark -
#pragma mark Private

+ (NSMutableString *)alphabetFromRange:(NSRange)range {
    NSMutableString *result = [NSMutableString string];
    for (char character = range.location; character < range.location + range.length; character += 1) {
        [result appendFormat:@"%c",character];
    }
    
    return result;
}

+ (instancetype)alphabetFromArray:(NSArray *)array {
    NSMutableString *result = [NSMutableString string];
    for (NSString *character in array) {
        [result appendFormat:@"%@",character];
    }
    
    return result;
}

@end
