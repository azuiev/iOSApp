//
//  AZModel.h
//  iOSApp
//
//  Created by Aleksey Zuiev on 03/08/2017.
//  Copyright © 2017 Aleksey Zuiev. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "AZObservableObject.h"

@interface AZModel : AZObservableObject <NSCoding>

//methods for subclassing purposes
- (void)save;
- (void)load;

@end
