//
//  AZSquareView.m
//  iOSApp
//
//  Created by Aleksey Zuiev on 04/07/2017.
//  Copyright © 2017 Aleksey Zuiev. All rights reserved.
//

#import "AZSquareView.h"

static NSUInteger AZMaxEnumValue = 3;
typedef NS_ENUM(NSUInteger, AZSquarePosition) {
    AZUpperLeft,
    AZUpperRight,
    AZDownRight,
    AZDownLeft
};

@interface AZSquareView ()
@property (nonatomic, unsafe_unretained) AZSquarePosition   position;

- (void)moveSquare;

@end

@implementation AZSquareView

#pragma mark -
#pragma mark Accessors

- (void)setSquare:(AZSquare *)square {
    if (_square != square) {
        _square = square;
    
        self.position = AZUpperLeft;
    }
}

#pragma mark -
#pragma mark Button handlers

- (IBAction)moveToNextCorner:(id)sender {
    [self setNextPosition];
    [self moveSquare];
}

- (IBAction)moveToRandomCorner:(id)sender {
    
}

#pragma mark -
#pragma mark Private

- (void)setNextPosition {
    AZSquarePosition position = self.position;
    position += 1;
    if (position > AZMaxEnumValue) {
        position = AZUpperLeft;
    }
    
    self.position = position;
}

- (CGPoint)calculateNewLocateion {
    CGSize parentSize = self.frame.size;
    CGSize size = self.squareView.frame.size;
    switch (self.position) {
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

- (void)moveSquare {
    CGPoint location = [self calculateNewLocateion];
    
    UIView *view = self.squareView;
    CGRect frame = view.frame;
    frame.origin = location;
    [UIView animateWithDuration:2.0
                          delay:0.0
                        options:UIViewAnimationOptionBeginFromCurrentState
                     animations: ^{
                         view.frame = frame;
                     }
                     completion:nil];
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/


@end
