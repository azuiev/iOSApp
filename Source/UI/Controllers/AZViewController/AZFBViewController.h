//
//  AZFBViewController.h
//  iOSApp
//
//  Created by Aleksey Zuiev on 03/10/2017.
//  Copyright © 2017 Aleksey Zuiev. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "AZView.h"
#import "AZContext.h"

@interface AZFBViewController : UIViewController
@property (nonatomic, readonly) AZView      *mainView;
@property (nonatomic, readonly) AZContext   *context;

- (void)prepareNavigationBar;
//method for children purposes. Do not call this method directly
- (void)showViewController;

@end
