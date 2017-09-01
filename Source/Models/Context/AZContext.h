//
//  AZContext.h
//  iOSApp
//
//  Created by Aleksey Zuiev on 01/09/2017.
//  Copyright © 2017 Aleksey Zuiev. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AZContext : NSObject

- (void)execute;
- (void)cancel;

//method for children purposes. Do not call this method directly
- (void)executeContext;

@end
