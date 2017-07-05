//
//  AZSquareView.h
//  iOSApp
//
//  Created by Aleksey Zuiev on 04/07/2017.
//  Copyright © 2017 Aleksey Zuiev. All rights reserved.
//

#import <UIKit/UIKit.h>

@class AZSquare;
@class AZButtonsView;

@interface AZSquareView : UIView
@property (nonatomic, strong) IBOutlet UIView      *squareView;
@property (nonatomic, strong) IBOutlet UIButton    *buttonNext;

@property (nonatomic, strong) AZSquare          *square;

- (IBAction)moveToNextCorner:(id)sender;

@end
