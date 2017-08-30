//
//  AZLoadingView.m
//  iOSApp
//
//  Created by Aleksey Zuiev on 10/08/2017.
//  Copyright © 2017 Aleksey Zuiev. All rights reserved.
//

#import "AZLoadingView.h"
#import "AZImageModel.h"

#import "AZMacros.h"

double AZMinAlpha = 0.0;
double AZMaxAlpha = 1.0;
double AZMinAnimationDuration = 0.0;
double AZMaxAnimationDuration = 1.5;


@interface AZLoadingView ()

- (void)addToSuperview:(UIView *)superview;

@end

@implementation AZLoadingView

#pragma mark -
#pragma mark Class Methods

+ (instancetype)viewWithSuperview:(UIView *)view {
    return [[self alloc] initWithSuperview:view];
}

- (instancetype)initWithSuperview:(UIView *)superview {
    if (self) {
        [self addToSuperview:superview];
    }
    
    return self;
}

#pragma mark -
#pragma mark Public Methods

- (void)addToSuperview:(UIView *)superview {
    self.frame = superview.bounds;
    
    [superview addSubview:self];
}

- (void)setVisible:(BOOL)visible {
    [self setVisible:visible animated:YES withCompletionHandler:nil];
}

- (void)setVisible:(BOOL)visible animated:(BOOL)animated {
     [self setVisible:visible animated:animated withCompletionHandler:nil];
}

- (void)    setVisible:(BOOL)visible
              animated:(BOOL)animated
 withCompletionHandler:(void(^)(BOOL))completionHandler
{
    if (_visible != visible) {
    
    AZWeakify(self);
    [UIView animateWithDuration:animated ? AZMaxAnimationDuration : AZMinAnimationDuration
                     animations:^ {
                         AZStrongify(self);
                         [self.activityIndicator startAnimating];
                         
                         self.alpha = visible ? AZMaxAlpha : AZMinAlpha;

                     }
                     completion:^(BOOL complete) {
                          _visible = visible;
                         
                         if (completionHandler) {
                             completionHandler(complete);
                         }
                     }];
    }
}

#pragma mark -
#pragma mark Private Methods



@end
