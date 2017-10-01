//
//  AZAssignRererenceWithSelector.h
//  idap
//
//  Created by Aleksey Zuiev on 18/06/2017.
//  Copyright © 2017 Aleksey Zuiev. All rights reserved.
//

#import "AZAssignReference.h"

@interface AZAssignRererenceWithSelector : AZAssignReference
@property (nonatomic, readonly) SEL   selector;

+ (instancetype)referenceWithTarger:(id)target selector:(SEL)selector;
- (void)performSelectorWithTarget;

@end
