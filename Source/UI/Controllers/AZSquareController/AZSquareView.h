//
//  AZSquareView.h
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
    AZDownLeft,
    AZPositionCount
};

@interface AZSquareView : UIView
@property (nonatomic, assign) AZSquarePosition   squarePosition;

@property (nonatomic, strong) IBOutlet UIView           *movingSquareView;
@property (nonatomic, strong) IBOutlet UIButton         *nextButton;
@property (nonatomic, strong) IBOutlet UIButton         *randomButton;
@property (nonatomic, strong) IBOutlet UIButton         *startStopButton;

- (void)setSquarePosition:(AZSquarePosition)squarePosition;

- (void)setSquarePosition:(AZSquarePosition)squarePosition
                 animated:(BOOL)animated;

- (void)setSquarePosition:(AZSquarePosition)squarePosition
                 animated:(BOOL)animated
        completionHandler:(void(^)(BOOL))completionHandler;

- (void)moveToNextPosition;
- (void)moveToRandomPosition;
- (void)startStopMoving;

@end
