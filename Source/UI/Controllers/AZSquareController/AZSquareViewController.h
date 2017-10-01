//
//  AZSquareViewController.h
//  iOSApp
//
//  Created by Aleksey Zuiev on 30/06/2017.
//  Copyright © 2017 Aleksey Zuiev. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "AZSquareView.h"

@interface AZSquareViewController : UIViewController

- (IBAction)moveToNextPosition:(id)sender;
- (IBAction)moveToRandomPosition:(id)sender;
- (IBAction)startStopMoving:(id)sender;

@end
