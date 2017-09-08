//
//  AZFBLoginViewController.m
//  iOSApp
//
//  Created by Aleksey Zuiev on 07/09/2017.
//  Copyright © 2017 Aleksey Zuiev. All rights reserved.
//

#import "AZFBLoginViewController.h"
#import "AZFBLoginContext.h"

@interface AZFBLoginViewController ()

@end

@implementation AZFBLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //FBSDKLoginButton *loginButton = [[FBSDKLoginButton alloc] init];
    
    //loginButton.center = self.view.center;
    
    //[self.view addSubview:loginButton];
}

- (IBAction)loginToFacebook:(id)sender {
    NSLog(@"Test");
    AZFBLoginContext *context = [AZFBLoginContext contextWithViewController:self];
    
    [context execute];
}

@end
