//
//  AZFBUserParser.h
//  iOSApp
//
//  Created by Aleksey Zuiev on 19/10/2017.
//  Copyright © 2017 Aleksey Zuiev. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "AZFBUserModel.h"

@interface AZFBUserParser : NSObject

+ (void)updateUser:(AZFBUserModel *)user withObject:(id)object;
+ (AZFBUserModel *)userWithObject:(id)object;

@end
