//
//  AZFBFriendsViewController.h
//  iOSApp
//
//  Created by Aleksey Zuiev on 11/09/2017.
//  Copyright © 2017 Aleksey Zuiev. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "AZFBUserModel.h"
#import "AZFBUsersModel.h"

@interface AZFBFriendsViewController : UIViewController
@property (nonatomic, strong) AZFBUsersModel    *friends;
@property (nonatomic, strong) AZFBUserModel     *user;

@end
