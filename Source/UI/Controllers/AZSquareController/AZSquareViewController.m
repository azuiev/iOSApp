//
//  AZSquareViewController.m
//  iOSApp
//
//  Created by Aleksey Zuiev on 30/06/2017.
//  Copyright © 2017 Aleksey Zuiev. All rights reserved.
//

#import "AZSquareViewController.h"

#import "AZSquareView.h"

#import "AZMacros.h"

AZBaseViewControllerWithProperty(AZSquareViewController, squareView, AZSquareView);

@implementation AZSquareViewController

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
