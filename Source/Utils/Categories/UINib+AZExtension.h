//
//  UINib+AZExtension.h
//  iOSApp
//
//  Created by Aleksey Zuiev on 16/07/2017.
//  Copyright © 2017 Aleksey Zuiev. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UINib (AZExtension)

+ (UINib *)nibWithClass:(Class)cls;
+ (UINib *)nibWithClass:(Class)cls bundle:(NSBundle *)bundle;

- (id)cellWithClass:(Class)cls;
- (id)cellWithClass:(Class)cls owner:(id)owner;
- (id)cellWithClass:(Class)cls options:(NSDictionary *)options;
- (id)cellWithClass:(Class)cls owner:(id)owner options:(NSDictionary *)options;

@end
