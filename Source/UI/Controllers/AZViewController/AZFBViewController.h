//
//  AZFBViewController.h
//  iOSApp
//
//  Created by Aleksey Zuiev on 03/10/2017.
//  Copyright © 2017 Aleksey Zuiev. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "AZView.h"

@interface AZFBViewController : UIViewController
@property (nonatomic, readonly) AZView    *mainView;
- (void)prepareNavigationBar;

@end
