//
//  UITableView+AZExtension.m
//  iOSApp
//
//  Created by Aleksey Zuiev on 27/07/2017.
//  Copyright © 2017 Aleksey Zuiev. All rights reserved.
//

#import "UITableView+AZExtension.h"

#import "UINib+AZExtension.h"

@implementation UITableView (AZExtension)

- (UITableViewCell *)cellWithClass:(Class)clazz {
    UITableViewCell *cell = [self dequeueReusableCellWithIdentifier:NSStringFromClass(clazz)];
    if (!cell) {
        cell = [UINib objectWithClass:clazz];
    }
    
    return cell;
}

@end

