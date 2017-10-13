//
//  AZFBFriendsViewController.h
//  iOSApp
//
//  Created by Aleksey Zuiev on 11/09/2017.
//  Copyright © 2017 Aleksey Zuiev. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "AZFBViewController.h"

#import "AZFBUserModel.h"
#import "AZFBUsersModel.h"

@interface AZFBFriendsViewController : AZFBViewController
@property (nonatomic, strong) AZFBUsersModel    *friends;

@end
