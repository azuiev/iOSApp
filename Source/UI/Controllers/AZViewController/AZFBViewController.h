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

#import "AZFBCurrentUser.h"

@interface AZFBViewController : UIViewController
@property (nonatomic, readonly) AZView          *mainView;
@property (nonatomic, strong)   AZContext       *context;
@property (nonatomic, strong)   AZModel         *model;
@property (nonatomic, strong)   AZFBCurrentUser *currentUser;

- (void)prepareNavigationBar;
//method for children purposes. Do not call this method directly
- (void)showViewController;

@end
