//
//  AZUsersViewController.h
//  iOSApp
//
//  Created by Aleksey Zuiev on 11/07/2017.
//  Copyright © 2017 Aleksey Zuiev. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#import "AZUserModel.h"
#import "AZUsersModel.h"

@interface AZUsersViewController : UIViewController <AZModelObserver>
@property (nonatomic, strong) AZUsersModel  *users;

@end
