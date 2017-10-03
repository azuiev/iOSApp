//
//  AZFBUserViewController.h
//  iOSApp
//
//  Created by Aleksey Zuiev on 18/09/2017.
//  Copyright © 2017 Aleksey Zuiev. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "AZViewController.h"

#import "AZFBUserModel.h"

#import "AZImageView.h"

@interface AZFBUserViewController : AZViewController
@property (nonatomic, strong) AZFBUserModel     *user;

@property (nonatomic, strong) IBOutlet UILabel      *nameLabel;
@property (nonatomic, strong) IBOutlet UILabel      *surnameLabel;
@property (nonatomic, strong) IBOutlet UILabel      *fatherNameLabel;
@property (nonatomic, strong) IBOutlet UILabel      *emailLabel;
@property (nonatomic, strong) IBOutlet UILabel      *genderLabel;
@property (nonatomic, strong) IBOutlet UILabel      *birthdayLabel;
@property (nonatomic, strong) IBOutlet AZImageView  *largeImageView;
@property (nonatomic, strong) IBOutlet UIButton     *friendsButton;

@end
