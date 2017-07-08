//
//  AZRootView.m
//  iOSApp
//
//  Created by Aleksey Zuiev on 04/07/2017.
//  Copyright © 2017 Aleksey Zuiev. All rights reserved.
//

#import "AZRootView.h"

static NSUInteger AZMaxEnumValue        = 3;
static NSUInteger AZAnimationDuration   = 2;


@interface AZRootView ()
@property (nonatomic, unsafe_unretained) BOOL squareMoving;
@end

@implementation AZRootView

#pragma mark -
#pragma mark Initialization and Deallocation
- (instancetype)init {
    self = [super init];
    if (self) {
        self.squareMoving = false;
    }
    
    return self;
}

#pragma mark -
#pragma mark Accessors

- (void)setSquareView:(UIView *)squareView {
    if (_squareView != squareView) {
        _squareView = squareView;
    
        self.squarePosition = AZUpperLeft;
    }
}

- (void)setSquareMoving:(BOOL)squareMoving {
    if (_squareMoving != squareMoving) {
        _squareMoving = squareMoving;
        
        if (squareMoving) {
            [self startMoving];
        }
    }
}

#pragma mark -
#pragma mark Public

- (IBAction)startStopMoving:(id)sender {
    self.squareMoving = !self.squareMoving;
}

- (void)setSquarePosition:(AZSquarePosition)squarePosition {
    [self setSquarePosition:squarePosition animated:YES completionHandler:^(BOOL finished) {
        _squarePosition = squarePosition;
    }];
}

- (void)setSquarePosition:(AZSquarePosition)squarePosition
                 animated:(BOOL)animated
{
    [self setSquarePosition:squarePosition animated:YES completionHandler:^(BOOL finished) {
        _squarePosition = squarePosition;
    }];
}

- (void)setSquarePosition:(AZSquarePosition)squarePosition
                 animated:(BOOL)animated
        completionHandler:(void(^)(BOOL))completionHandler
{
    CGPoint location = [self calculateNewLocation:squarePosition];
    UIView *squareView = self.squareView;
    CGRect frame = squareView.frame;
    frame.origin = location;
    
    if (!animated) {
        squareView.frame = frame;
        completionHandler(true);
    } else {
        [UIView animateWithDuration:AZAnimationDuration
                              delay:0.0
                            options:UIViewAnimationOptionBeginFromCurrentState
                         animations: ^{
                             squareView.frame = frame;
                         }
                         completion:completionHandler];
    }
}

#pragma mark -
#pragma mark Button handlers

- (IBAction)moveToNextCorner:(id)sender {
    [self setSquarePosition:[self nextPosition] animated:YES];
}

- (IBAction)moveToRandomCorner:(id)sender {
    [self setSquarePosition:[self randomPosition] animated:YES];
}

#pragma mark -
#pragma mark Private

- (void)startMoving {
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0);
    dispatch_async(queue, ^ {
        if (self.squareMoving) {
            dispatch_async(dispatch_get_main_queue(), ^{
                [self moveToNextCorner:nil];
            });
            
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(AZAnimationDuration * NSEC_PER_SEC)),
                           queue,  ^{
                               [self startMoving];
                           });
        }
    });
}

- (AZSquarePosition)nextPosition {
    AZSquarePosition position = self.squarePosition;
    position += 1;
    if (position > AZMaxEnumValue) {
        position = AZUpperLeft;
    }
    
    return position;
}

- (AZSquarePosition)randomPosition {
    return arc4random_uniform((uint32_t)AZMaxEnumValue);
}

- (CGPoint)calculateNewLocation:(AZSquarePosition)position {
    CGSize parentSize = self.frame.size;
    CGSize size = self.squareView.frame.size;
    
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

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
