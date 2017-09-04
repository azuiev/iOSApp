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
@property (nonatomic, strong)   IBOutlet UIActivityIndicatorView   *activityIndicator;

@property (nonatomic, assign, getter=isVisible) BOOL    visible;

+ (instancetype)viewWithSuperview:(UIView *)superview;

- (void)addToSuperview:(UIView *)superview;

- (void)setVisible:(BOOL)visible animated:(BOOL)animated;
- (void)    setVisible:(BOOL)visible
              animated:(BOOL)animated
     completionHandler:(void(^)(BOOL))completionHandler;

@end
