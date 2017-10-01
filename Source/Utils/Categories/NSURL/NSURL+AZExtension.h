//
//  NSURL+AZExtension.h
//  iOSApp
//
//  Created by Aleksey Zuiev on 01/10/2017.
//  Copyright © 2017 Aleksey Zuiev. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSURL (AZExtension)

- (NSString *)pathWithRemovingIllegalSymbols;
    
@end
