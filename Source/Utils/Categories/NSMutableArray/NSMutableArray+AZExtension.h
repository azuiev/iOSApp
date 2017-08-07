//
//  NSMutableArray+AZExtension.h
//  iOSApp
//
//  Created by Aleksey Zuiev on 01/08/2017.
//  Copyright © 2017 Aleksey Zuiev. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSMutableArray (AZExtension)

- (void)moveRowAtIndex:(NSUInteger)sourceIndex toIndex:(NSUInteger)destinationIndex;

@end
