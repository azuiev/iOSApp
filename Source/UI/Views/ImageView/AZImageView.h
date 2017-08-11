//
//  AZImageView.h
//  iOSApp
//
//  Created by Aleksey Zuiev on 20/07/2017.
//  Copyright © 2017 Aleksey Zuiev. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "AZLoadingView.h"
#import "AZImageModel.h"

@interface AZImageView : UIView <AZModelObserver>
@property (nonatomic, strong) IBOutlet  UIImageView     *contentImageView;
@property (nonatomic, strong) IBOutlet  AZLoadingView   *loadingView;

@property (nonatomic, strong) AZImageModel  *imageModel;

@end
