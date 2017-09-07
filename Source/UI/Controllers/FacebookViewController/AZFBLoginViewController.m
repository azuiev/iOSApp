//
//  AZFBLoginViewController.m
//  iOSApp
//
//  Created by Aleksey Zuiev on 07/09/2017.
//  Copyright © 2017 Aleksey Zuiev. All rights reserved.
//

#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import <FBSDKLoginKit/FBSDKLoginKit.h>

#import "AZFBLoginViewController.h"

@interface AZFBLoginViewController ()

@end

@implementation AZFBLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    FBSDKLoginButton *loginButton = [[FBSDKLoginButton alloc] init];

    loginButton.center = self.view.center;
    
    [self.view addSubview:loginButton];
}

- (IBAction)loginToFacebook:(id)sender {
    NSLog(@"Test");
    //[AZFBLoginContext execute];
}


@end
