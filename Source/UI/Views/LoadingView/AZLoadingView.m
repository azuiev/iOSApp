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

@implementation AZLoadingView

#pragma mark -
#pragma mark Class Methods

+ (instancetype)viewWithSuperview:(UIView *)view {
    return [[self alloc] initWithSuperview:view];
}

- (instancetype)initWithSuperview:(UIView *)superview {
    if (self) {
        self.frame = superview.bounds;
        [superview addSubview:self];
    }
    
    return self;
}

#pragma mark -
#pragma mark Public Methods

- (void)setVisible:(BOOL)visible {
    [self setVisible:visible animated:YES completionHandler:nil];
}

- (void)setVisible:(BOOL)visible animated:(BOOL)animated {
     [self setVisible:visible animated:animated completionHandler:nil];
}

- (void)    setVisible:(BOOL)visible
              animated:(BOOL)animated
     completionHandler:(void(^)(BOOL))completionHandler
{
    [self.activityIndicator startAnimating];
    
    AZWeakify(self);
    [UIView animateWithDuration:animated ? AZMaxAnimationDuration : AZMinAnimationDuration
                     animations:^ {
                         AZStrongify(self);
                         self.alpha = visible ? AZMaxAlpha : AZMinAlpha;
                     }
                     completion:^(BOOL complete) {
                          _visible = visible;
                         
                         if (completionHandler) {
                             completionHandler(complete);
                         }
                     }];
}

#pragma mark -
#pragma mark Private Methods

@end
