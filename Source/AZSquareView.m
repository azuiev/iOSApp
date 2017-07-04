//
//  AZSquareView.m
//  iOSApp
//
//  Created by Aleksey Zuiev on 04/07/2017.
//  Copyright © 2017 Aleksey Zuiev. All rights reserved.
//

#import "AZSquareView.h"


typedef NS_ENUM(NSUInteger, AZSquarePosition) {
    AZUpperLeft,
    AZUpperRight,
    AZDownLeft,
    AZDownRight
};

@interface AZSquareView ()
@property (nonatomic, unsafe_unretained) AZSquarePosition   position;

@end

@implementation AZSquareView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
