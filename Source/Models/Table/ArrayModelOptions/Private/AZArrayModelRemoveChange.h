//
//  AZArrayModelRemoveChange.h
//  iOSApp
//
//  Created by Aleksey Zuiev on 27/07/2017.
//  Copyright © 2017 Aleksey Zuiev. All rights reserved.
//

#import "AZArrayModelChange.h"

@interface AZArrayModelRemoveChange : AZArrayModelChange

-  (instancetype)initWithIndex:(NSUInteger)index;

@end
