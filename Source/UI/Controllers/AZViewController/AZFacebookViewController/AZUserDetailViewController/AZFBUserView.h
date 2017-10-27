//
//  AZFBUserView.h
//  iOSApp
//
//  Created by Aleksey Zuiev on 18/09/2017.
//  Copyright © 2017 Aleksey Zuiev. All rights reserved.
//

#import "AZView.h"
#import "AZImageView.h"

@interface AZFBUserView : AZView
@property (nonatomic, strong) IBOutlet UILabel      *nameLabel;
@property (nonatomic, strong) IBOutlet UILabel      *surnameLabel;
@property (nonatomic, strong) IBOutlet UILabel      *middleNameLabel;
@property (nonatomic, strong) IBOutlet UILabel      *genderLabel;
@property (nonatomic, strong) IBOutlet UILabel      *birthdayLabel;
@property (nonatomic, strong) IBOutlet AZImageView  *largeImageView;
@property (nonatomic, strong) IBOutlet UIButton     *friendsButton;

@end
