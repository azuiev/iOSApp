//
//  AZTableViewCell.m
//  iOSApp
//
//  Created by Aleksey Zuiev on 14/07/2017.
//  Copyright © 2017 Aleksey Zuiev. All rights reserved.
//

#import "AZTableViewCell.h"

@implementation AZTableViewCell

#pragma mark -
#pragma mark Accessors

- (NSString *)reuseIdentifier {
    return NSStringFromClass([self class]);
}

@end
