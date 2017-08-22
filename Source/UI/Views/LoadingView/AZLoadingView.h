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

@property (nonatomic, readonly, getter=isVisible) BOOL    visible;

+ (instancetype)viewWithSuperview:(UIView *)superview;

- (instancetype)initWithSuperview:(UIView *)superview;

- (void)addAsSubview:(UIView *)view;

- (void)setVisible:(BOOL)visible;
- (void)setVisible:(BOOL)visible anymated:(BOOL)anymated;
- (void)    setVisible:(BOOL)visible
              anymated:(BOOL)anymated
 withCompletionHandler:(void(^)(BOOL))completionHandler;

@end
