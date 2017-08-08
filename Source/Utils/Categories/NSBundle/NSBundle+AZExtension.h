//
//  NSBundle+AZExtension.h
//  iOSApp
//
//  Created by Aleksey Zuiev on 01/08/2017.
//  Copyright © 2017 Aleksey Zuiev. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NSBundle (AZExtension)

- (id)objectWithClass:(Class)cls;
- (id)objectWithClass:(Class)cls owner:(id)owner;
- (id)objectWithClass:(Class)cls options:(NSDictionary *)options;
- (id)objectWithClass:(Class)cls owner:(id)owner options:(NSDictionary *)options;

@end
