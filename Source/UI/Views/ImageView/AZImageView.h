//
//  AZImageView.h
//  iOSApp
//
//  Created by Aleksey Zuiev on 20/07/2017.
//  Copyright © 2017 Aleksey Zuiev. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "AZImageModel.h"
#import "AZView.h"

@interface AZImageView : AZView
@property (nonatomic, strong) UIImageView   *contentImageView;
@property (nonatomic, strong) AZImageModel  *model;

@end
