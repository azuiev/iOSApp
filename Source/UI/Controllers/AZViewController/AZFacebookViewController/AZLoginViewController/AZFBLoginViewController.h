//
//  AZFBLoginViewController.h
//  iOSApp
//
//  Created by Aleksey Zuiev on 07/09/2017.
//  Copyright © 2017 Aleksey Zuiev. All rights reserved.
//

#import <UIKit/UIKit.h>

@class AZFBViewController;

@interface AZFBLoginViewController : UIViewController
@property (nonatomic, strong) IBOutlet UIButton *loginButton;

- (void)presentChildController:(AZFBViewController *)controller;

@end
