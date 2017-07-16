//
//  UINib+AZExtension.m
//  iOSApp
//
//  Created by Aleksey Zuiev on 16/07/2017.
//  Copyright © 2017 Aleksey Zuiev. All rights reserved.
//

#import "UINib+AZExtension.h"

@implementation UINib (AZExtension)

+ (UINib *)nibWithClass:(Class)cls {
    return [self nibWithClass:cls bundle:nil];
}

+ (UINib *)nibWithClass:(Class)cls bundle:(NSBundle *)bundle {
    return [UINib nibWithNibName:NSStringFromClass(cls)
                          bundle:bundle];
}

- (id)cellWithClass:(Class)cls {
    return [self cellWithClass:cls owner:nil options:nil];
}

- (UITableViewCell *)cellWithClass:(Class)cls owner:(id)owner {
    return [self cellWithClass:cls owner:owner options:nil];
}

- (UITableViewCell *)cellWithClass:(Class)cls options:(NSDictionary *)options {
    return [self cellWithClass:cls owner:nil options:options];
}

- (UITableViewCell *)cellWithClass:(Class)cls owner:(id)owner options:(NSDictionary *)options {
    NSArray *cells = [self instantiateWithOwner:owner options:options];
    
    for (id cell in cells) {
        if ([cell isMemberOfClass:cls]) {
            return cell;
        }
    }
    
    return nil;
}

@end
