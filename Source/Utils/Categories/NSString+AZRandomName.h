//
//  NSString+AZRandomName.h
//  idap
//
//  Created by Aleksey Zuiev on 16/05/2017.
//  Copyright © 2017 Aleksey Zuiev. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (AZRandomName)

+ (NSString *)randomName;
+ (NSString *)randomNameWithLength:(NSUInteger)length;
+ (NSString *)randomNameWithLengthInRange:(NSRange)range;

@end
