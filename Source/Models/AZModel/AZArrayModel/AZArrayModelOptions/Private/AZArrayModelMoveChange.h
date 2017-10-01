//
//  AZArrayModelMoveChange.h
//  iOSApp
//
//  Created by Aleksey Zuiev on 01/08/2017.
//  Copyright © 2017 Aleksey Zuiev. All rights reserved.
//

#import "AZArrayModelChange.h"

@interface AZArrayModelMoveChange : AZArrayModelChange

-  (instancetype)initWithSourceIndex:(NSUInteger)sourceIndex
                    destinationIndex:(NSUInteger)destinationIndex;
@end
