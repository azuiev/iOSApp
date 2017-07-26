//
//  AZSquareView.m
//  iOSApp
//
//  Created by Aleksey Zuiev on 04/07/2017.
//  Copyright © 2017 Aleksey Zuiev. All rights reserved.
//

#import "AZSquareView.h"

#import "AZRandomNumber.h"

static double AZAnimationDuration   = 2.0;

@interface AZSquareView ()
@property (nonatomic, assign, getter=isSquareMoving)    BOOL    squareMoving;
@property (nonatomic, assign, getter=isSquareCycling)   BOOL    squareCycling;

@property (nonatomic, assign) BOOL  shouldStopMoving;

- (void)moveSquare;
- (AZSquarePosition)nextPosition;
- (AZSquarePosition)randomPosition;
- (CGRect)frameForPosition:(AZSquarePosition)squarePosition;

@end

@implementation AZSquareView

#pragma mark -
#pragma mark Accessors

- (void)setSquareView:(UIView *)movingSquareView {
    if (_movingSquareView != movingSquareView) {
        _movingSquareView = movingSquareView;
    
        self.squarePosition = AZUpperLeft;
    }
}

- (void)setSquareCycling:(BOOL)squareCycling {
    if (_squareCycling != squareCycling) {
        _squareCycling = squareCycling;
        
        if (squareCycling) {
            [self moveSquare];
        }
    }
}

#pragma mark -
#pragma mark Public

- (void)startStopMoving {
    if (!self.squareCycling) {
        if (self.squareMoving) {
            return;
        }
        
        self.squareCycling = YES;
    } else {
        self.shouldStopMoving = !self.shouldStopMoving;
    }
}

- (void)setSquarePosition:(AZSquarePosition)squarePosition {
    [self setSquarePosition:squarePosition animated:YES];
}

- (void)setSquarePosition:(AZSquarePosition)squarePosition
                 animated:(BOOL)animated
{
    [self setSquarePosition:squarePosition animated:animated completionHandler:nil];
}

- (void)setSquarePosition:(AZSquarePosition)squarePosition
                 animated:(BOOL)animated
        completionHandler:(void(^)(BOOL))completionHandler
{
    self.squareMoving = YES;
    
    [UIView animateWithDuration:animated ? AZAnimationDuration : 0.0
                          delay:0.0
                        options:UIViewAnimationOptionBeginFromCurrentState
                     animations:^{
                         self.movingSquareView.frame = [self frameForPosition:squarePosition];
                     }
                     completion:^(BOOL finished) {
                         if (completionHandler) {
                             completionHandler(true);
                         }
                         
                         if (_squarePosition != squarePosition) {
                             _squarePosition = squarePosition;
                         }
                         
                         if (!self.squareCycling) {
                             self.squareMoving = NO;
                         }
                     }];
}

#pragma mark -
#pragma mark Button handlers

- (void)moveToNextPosition {
    if (!self.squareCycling) {
        [self setSquarePosition:[self nextPosition] animated:YES];
    }
}

- (void)moveToRandomPosition {
    if (!self.squareCycling) {
        [self setSquarePosition:[self randomPosition] animated:YES];
    }
}

#pragma mark -
#pragma mark Private

- (void)moveSquare {
    __weak AZSquareView *weakSelf = self;
    [self setSquarePosition:[self nextPosition]
                   animated:YES
          completionHandler:^(BOOL finished) {
              __strong AZSquareView *strongSelf = weakSelf;
              if (strongSelf.squareCycling && !strongSelf.shouldStopMoving) {
                  [strongSelf moveSquare];
              } else {
                  strongSelf.shouldStopMoving = NO;
                  strongSelf.squareCycling = NO;
              }
          }];
}

- (AZSquarePosition)nextPosition {
    return self.squarePosition + 1 % AZPositionCount;
}

- (AZSquarePosition)randomPosition {
    AZSquarePosition position = (AZSquarePosition)AZRandomNumberWithMaxValue(AZPositionCount - 1);
    if (!self.squareMoving) {
        while (self.squarePosition == position) {
            position = AZRandomNumberWithMaxValue(AZPositionCount - 1);
        }
    }

    return position;
}

- (CGRect)frameForPosition:(AZSquarePosition)squarePosition {
    CGRect frame = self.movingSquareView.frame;
    CGSize size = frame.size;
    CGSize parentSize = self.frame.size;
    
    float distanceX = parentSize.width - size.width;
    float distanceY = parentSize.height - size.width;
    
    CGPoint point = CGPointZero;
    
    switch (squarePosition) {
        case AZUpperLeft:
            break;
        case AZUpperRight:
            point.x += distanceX;
            break;
        case AZDownLeft:
            point.y += distanceY;
            break;
        case AZDownRight:
            point.x += distanceX;
            point.y += distanceY;
        default:
            break;
    }
    
    frame.origin = point;
    
    return frame;
}

#pragma mark -
#pragma mark View Lifecycle

- (void)awakeFromNib {
    [super awakeFromNib];
    
    CALayer *layer = [CALayer new];
    NSArray *buttons = @[self.nextButton, self.randomButton, self.startStopButton];
    for (UIButton *button in buttons) {
        layer = button.layer;
        layer.borderWidth = 1;
        layer.cornerRadius = 10;
    }
}

@end
