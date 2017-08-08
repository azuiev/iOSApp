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

- (UITableViewCell *)reusableCellWithClass:(Class)cls {
    UITableViewCell *cell = [self dequeueReusableCellWithIdentifier:NSStringFromClass(cls)];
    if (!cell) {
        cell = [UINib objectWithClass:cls];
    }
    
    return cell;
}

@end

