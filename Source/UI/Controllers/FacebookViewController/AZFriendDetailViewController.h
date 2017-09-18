//
//  AZFriendDetailViewController.h
//  iOSApp
//
//  Created by Aleksey Zuiev on 18/09/2017.
//  Copyright © 2017 Aleksey Zuiev. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "AZFBUserModel.h"

#import "AZImageView.h"

@interface AZFriendDetailViewController : UIViewController
@property (nonatomic, strong) AZFBUserModel     *friend;

@property (nonatomic, strong) IBOutlet UILabel      *nameLabel;
@property (nonatomic, strong) IBOutlet UILabel      *surnameLabel;
@property (nonatomic, strong) IBOutlet AZImageView  *friendImageView;

@end
