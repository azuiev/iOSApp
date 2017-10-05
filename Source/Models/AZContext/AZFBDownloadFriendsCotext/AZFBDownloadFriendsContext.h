//
//  AZFBDownloadFriendsContext.h
//  iOSApp
//
//  Created by Aleksey Zuiev on 13/09/2017.
//  Copyright © 2017 Aleksey Zuiev. All rights reserved.
//

#import "AZGetContext.h"
#import "AZFBUserModel.h"
#import "AZFBUsersModel.h"

@interface AZFBDownloadFriendsContext : AZGetContext
@property (nonatomic, strong) AZFBUserModel     *user;
@property (nonatomic, strong) AZFBUsersModel    *friends;

@end
