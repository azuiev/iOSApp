//
//  AZArrayModelOptions.h
//  iOSApp
//
//  Created by Aleksey Zuiev on 27/07/2017.
//  Copyright © 2017 Aleksey Zuiev. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AZArrayModelOptions : NSObject

+ (instancetype)arrayModelRemoveWithIndexes:(NSArray *)indexes;

//method to override in children classes. Do not call this method directly
- (id)modelOptions;

@end
