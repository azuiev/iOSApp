//
//  AZFBFriendsContext.h
//  iOSApp
//
//  Created by Aleksey Zuiev on 13/09/2017.
//  Copyright © 2017 Aleksey Zuiev. All rights reserved.
//

#import "AZFBGetContext.h"
#import "AZFBUsersModel.h"

@interface AZFBFriendsContext : AZFBGetContext
@property (nonatomic, readonly) AZFBUsersModel  *friends;

@end
