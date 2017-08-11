//
//  AZLoadingView.h
//  iOSApp
//
//  Created by Aleksey Zuiev on 10/08/2017.
//  Copyright © 2017 Aleksey Zuiev. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "AZModel.h"

@interface AZLoadingView : UIView <AZModelObserver>
@property (nonatomic, strong) IBOutlet UIActivityIndicatorView   *activityIndicator;

@property (nonatomic, strong)   AZModel     *model;

+ (instancetype)initWithView:(UIView *)view;

@end
