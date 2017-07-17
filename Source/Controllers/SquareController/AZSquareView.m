//
//  AZSquareView.m
//  iOSApp
//
//  Created by Aleksey Zuiev on 04/07/2017.
//  Copyright © 2017 Aleksey Zuiev. All rights reserved.
//

#import "AZSquareView.h"

#import "AZRandomNumber.h"

static NSUInteger AZAnimationDuration   = 2;

@interface AZSquareView ()
@property (nonatomic, assign, getter=isSquareMoving)    BOOL  squareMoving;
@property (nonatomic, assign)   NSUInteger    buttonPressedCount;
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

- (void)setSquareMoving:(BOOL)squareMoving {
    if (_squareMoving != squareMoving) {
        _squareMoving = squareMoving;
        
        self.buttonPressedCount += 1;
        
        if (squareMoving) {
            [self moveSquare];
        }
        
    }
}

#pragma mark -
#pragma mark Public

- (void)startStopMoving {
    self.squareMoving = !self.squareMoving;
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
    NSTimeInterval interval = animated ? AZAnimationDuration : 0.0;
    
    [UIView animateWithDuration:interval
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
                     }];
}

#pragma mark -
#pragma mark Button handlers

- (void)moveToNextPosition {
    if (!self.squareMoving) {
        [self setSquarePosition:[self nextPosition] animated:YES];
    }}

- (void)moveToRandomPosition {
    if (!self.squareMoving) {
        [self setSquarePosition:[self randomPosition] animated:YES];
    }
}

#pragma mark -
#pragma mark Private

- (void)moveSquare {
    if (self.buttonPressedCount > 1) {
        return;
    }
    
    __weak AZSquareView *weakSelf = self;
    [self setSquarePosition:[self nextPosition]
                   animated:YES
          completionHandler:^(BOOL finished) {
              __strong AZSquareView *strongSelf = weakSelf;
              strongSelf.buttonPressedCount = 0;
              if (strongSelf.squareMoving) {
                  [strongSelf moveSquare];
              }
          }];
}


- (AZSquarePosition)nextPosition {
    AZSquarePosition position = self.squarePosition + 1;
   
    return position >= AZPositionCount ? AZUpperLeft : position;
}

- (AZSquarePosition)randomPosition {
    return AZRandomNumberWithMaxValue(AZPositionCount);
}

- (CGRect)frameForPosition:(AZSquarePosition)squarePosition {
    CGRect frame = self.movingSquareView.frame;
    frame.origin = [self locationForPosition:squarePosition];
    
    return frame;

}
- (CGPoint)locationForPosition:(AZSquarePosition)position {
    CGSize parentSize = self.frame.size;
    CGSize size = self.movingSquareView.frame.size;
    
    switch (position) {
        case AZUpperLeft:
            return CGPointMake(0, 0);
        case AZUpperRight:
            return CGPointMake(parentSize.width - size.width, 0);
        case AZDownLeft:
            return CGPointMake(0, parentSize.height - size.height);
        case AZDownRight:
            return CGPointMake(parentSize.width - size.width, parentSize.height - size.height);
        default:
            return CGPointMake(0, 0);
    }
    
}

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
