//
//  UITableView+AZExtension.h
//  iOSApp
//
//  Created by Aleksey Zuiev on 27/07/2017.
//  Copyright © 2017 Aleksey Zuiev. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AZArrayModelChange.h"

@interface UITableView (AZExtension)

- (id)reusableCellWithClass:(Class)cls;

- (void)applyChangesWithObject:(AZArrayModelChange *)object;

@end
