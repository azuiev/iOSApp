//
//  AZSquareViewController.m
//  iOSApp
//
//  Created by Aleksey Zuiev on 30/06/2017.
//  Copyright © 2017 Aleksey Zuiev. All rights reserved.
//

#import "AZSquareViewController.h"

#import "AZSquareView.h"

@interface AZSquareViewController ()
@property (nonatomic, strong) AZSquareView    *squareView;

@end

@implementation AZSquareViewController

@dynamic squareView;

#pragma mark -
#pragma mark Accessors

- (AZSquareView *)squareView {
    if ([self isViewLoaded] && [self.view isKindOfClass:[AZSquareView class]]) {
        return (AZSquareView *)self.view;
    }
    
    return nil;
}

#pragma mark -
#pragma mark UI handlers

- (IBAction)moveToNextPosition:(id)sender {
    [self.squareView moveToNextPosition];
}

- (IBAction)moveToRandomPosition:(id)sender {
    [self.squareView moveToRandomPosition];
}

- (IBAction)startStopMoving:(id)sender {
    [self.squareView startStopMoving];
}

@end
