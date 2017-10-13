//
//  AZFBViewController.m
//  iOSApp
//
//  Created by Aleksey Zuiev on 03/10/2017.
//  Copyright © 2017 Aleksey Zuiev. All rights reserved.
//

#import "AZFBViewController.h"

#import "AZFBUserModel.h"
#import "AZFBLogoutContext.h"

#import "AZGCD.h"

@interface AZFBViewController ()
@property (nonatomic, strong) AZView    *mainView;

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

#pragma mark -
#pragma mark AZModelObserver

- (void)modelDidLoad:(AZFBUserModel *)model {
    [AZGCD dispatchAsyncOnMainQueue:^ {
        [self.mainView.loadingView setVisible:NO];
        [self.mainView fillWithModel:model];
    }];
}

- (void)modelWillLoad:(AZModel *)model {
    [AZGCD dispatchAsyncOnMainQueue:^ {
        [self.mainView.loadingView setVisible:YES];
    }];
}

@end
