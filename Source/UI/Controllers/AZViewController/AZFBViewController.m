//
//  AZFBViewController.m
//  iOSApp
//
//  Created by Aleksey Zuiev on 03/10/2017.
//  Copyright © 2017 Aleksey Zuiev. All rights reserved.
//

#import <FBSDKLoginKit/FBSDKLoginKit.h>
#import <FBSDKCoreKit/FBSDKCoreKit.h>

#import "AZFBViewController.h"

#import "AZFBUserModel.h"
#import "AZFBLogoutContext.h"

#import "AZGCD.h"
#import "AZMacros.h"

@interface AZFBViewController ()
@property (nonatomic, strong) AZView    *mainView;

@end

@implementation AZFBViewController

#pragma mark -
#pragma mark Initialization and Deallocation

- (void)dealloc {
    self.mainView = nil;
    self.context = nil;
    self.model = nil;
    self.currentUser = nil;
}

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
        _context.currentUser = self.currentUser;
        [_context execute];
    }
}

- (void)setModel:(AZModel *)model {
    if (_model != model) {
        [_model removeObserver:self];
        
        _model = model;
        [_model addObserver:self];
    }
}

#pragma mark -
#pragma mark Public Methods

- (void)showViewController {

}

#pragma mark -
#pragma mark Interface Handling

- (void)onLogout {
    [self logout];
}

#pragma mark -
#pragma mark Private Methods

- (void)logout {
    self.context = [AZFBLogoutContext contextWithModel:self.currentUser];
}

#pragma mark -
#pragma mark AZModelObserver

- (void)modelDidLoad:(AZModel *)model {
    AZWeakify(self);
    [AZGCD dispatchAsyncOnMainQueue:^ {
        AZStrongify(self);
        [self.mainView.loadingView setVisible:NO];
        [self.mainView fillWithModel:model];
    }];
}

- (void)modelWillLoad:(AZModel *)model {
    AZWeakify(self);
    [AZGCD dispatchAsyncOnMainQueue:^ {
        AZStrongify(self);
        [self.mainView.loadingView setVisible:YES];
    }];
}

- (void)modelDidUnload:(AZFBUserModel *)model {
    AZWeakify(self);
    [AZGCD dispatchAsyncOnMainQueue:^ {
        AZStrongify(self);
        [self.currentUser clearToken];
        [self dismissViewControllerAnimated:YES completion:nil];
    }];
}

@end
