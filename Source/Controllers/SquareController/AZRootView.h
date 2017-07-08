//
//  AZRootView.h
//  iOSApp
//
//  Created by Aleksey Zuiev on 04/07/2017.
//  Copyright © 2017 Aleksey Zuiev. All rights reserved.
//

#import <UIKit/UIKit.h>

@class AZButtonView;

typedef NS_ENUM(NSUInteger, AZSquarePosition) {
    AZUpperLeft,
    AZUpperRight,
    AZDownRight,
    AZDownLeft
};

@interface AZRootView : UIView
@property (nonatomic, unsafe_unretained) AZSquarePosition   squarePosition;

@property (nonatomic, strong) IBOutlet UIView           *squareView;
@property (nonatomic, strong) IBOutlet UIButton         *nextButton;
@property (nonatomic, strong) IBOutlet UIButton         *randomButton;
@property (nonatomic, strong) IBOutlet UIButton         *startStopButton;

- (IBAction)moveToNextCorner:(id)sender;
- (IBAction)moveToRandomCorner:(id)sender;
- (IBAction)startStopMoving:(id)sender;
@end
