//
//  AZUsersViewCell.h
//  iOSApp
//
//  Created by Aleksey Zuiev on 11/07/2017.
//  Copyright © 2017 Aleksey Zuiev. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "AZTableViewCell.h"
#import "AZStatefulImageView.h"
#import "AZUserModel.h"

@interface AZUserCell : AZTableViewCell
@property (nonatomic, strong) IBOutlet AZStatefulImageView      *userImageView;
@property (nonatomic, strong) IBOutlet UILabel                  *fullNameLabel;

@property (nonatomic, strong) AZUserModel    *user;

- (void)fillWithModel:(AZUserModel *)user;

@end
