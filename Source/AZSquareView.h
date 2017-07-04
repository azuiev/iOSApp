//
//  AZSquareView.h
//  iOSApp
//
//  Created by Aleksey Zuiev on 04/07/2017.
//  Copyright © 2017 Aleksey Zuiev. All rights reserved.
//

#import <UIKit/UIKit.h>

@class AZSquare;

@interface AZSquareView : UIView
@property (nonatomic, strong) IBOutlet UILabel  *squareLabel;
@property (nonatomic, strong) AZSquare          *square;

@end
