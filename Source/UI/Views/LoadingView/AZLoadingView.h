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

+ (instancetype)initWithView:(UIView *)view;
+ (instancetype)initWithView:(UIView *)view bounds:(CGRect)bounds;

- (instancetype)initWithView:(UIView *)view;
- (instancetype)initWithView:(UIView *)view bounds:(CGRect)bounds;

- (void)addAsSubiew:(UIView *)view;
- (void)addAsSubiew:(UIView *)view bounds:(CGRect)bounds;

- (void)startAnimating;
- (void)stopAnimating;

@end
