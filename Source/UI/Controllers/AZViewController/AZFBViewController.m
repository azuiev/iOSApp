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

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self prepareNavigationBar];
}

- (void)prepareNavigationBar {
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Logout"
                                                                              style:UIBarButtonItemStyleDone
                                                                             target:self
                                                                             action:@selector(onLogout)];
}

#pragma mark -
#pragma mark Accessors

- (void)setContext:(AZContext *)context {
    if (_context != context) {
        [_context cancel];
        
        _context = context;
        [_context execute];
    }
}

#pragma mark -
#pragma mark Public Methods

- (void)showViewController {

}

#pragma mark -
#pragma mark Interface Handling

- (void)onLogout {
    [[AZFBLogoutContext contextWithModel:nil] execute];
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark -
#pragma mark AZModelObserver

- (void)modelDidLoad:(AZFBUserModel *)model {
    [AZGCD dispatchAsyncOnMainQueue:^ {
        [self showViewController];
       //[self.mainView.loadingView setVisible:NO];

    }];
}

- (void)modelWillLoad:(AZModel *)model {
    [AZGCD dispatchAsyncOnMainQueue:^ {
        [self.mainView.loadingView setVisible:YES];
    }];
}

@end
