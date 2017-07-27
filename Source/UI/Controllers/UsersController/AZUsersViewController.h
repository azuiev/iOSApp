//
//  AZUsersViewController.h
//  iOSApp
//
//  Created by Aleksey Zuiev on 11/07/2017.
//  Copyright © 2017 Aleksey Zuiev. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#import "AZUser.h"
#import "AZArrayModel.h"

@interface AZUsersViewController : UIViewController
@property (nonatomic, strong) AZArrayModel  *users;

@end
