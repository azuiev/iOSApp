//
//  AZFBViewController.m
//  iOSApp
//
//  Created by Aleksey Zuiev on 03/10/2017.
//  Copyright © 2017 Aleksey Zuiev. All rights reserved.
//

#import "AZFBViewController.h"

#import "AZFBLogoutContext.h"

@interface AZFBViewController ()

@end

@implementation AZFBViewController

#pragma mark -
#pragma mark Initialization and Deallocation

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self prepareNavigationBar];
}

- (void)prepareNavigationBar {
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Logout"
                                                                              style:UIBarButtonItemStyleDone
                                                                             target:self
                                                                             action:@selector(onLogout)];
}

#pragma mark -
#pragma mark UI Actions

- (void)onLogout {
    [[AZFBLogoutContext contextWithModel:nil] execute];
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
