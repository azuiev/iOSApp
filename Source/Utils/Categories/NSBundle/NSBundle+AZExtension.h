//
//  NSBundle+AZExtension.h
//  iOSApp
//
//  Created by Aleksey Zuiev on 01/08/2017.
//  Copyright © 2017 Aleksey Zuiev. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NSBundle (AZExtension)

- (UINib *)nibByClass:(Class)cls;
- (UINib *)nibByClass:(Class)cls owner:(id)owner;
- (UINib *)nibByClass:(Class)cls options:(NSDictionary *)options;
- (UINib *)nibByClass:(Class)cls owner:(id)owner options:(NSDictionary *)options;

@end
