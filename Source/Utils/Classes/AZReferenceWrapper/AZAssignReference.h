//
//  AZAssignReference.h
//  idap
//
//  Created by Aleksey Zuiev on 25/05/2017.
//  Copyright © 2017 Aleksey Zuiev. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AZAssignReference : NSObject
@property (nonatomic, readonly) id  target;

+ (instancetype)referenceWithTarger:(id)target;

- (instancetype)initWithTarget:(id)target;

@end
