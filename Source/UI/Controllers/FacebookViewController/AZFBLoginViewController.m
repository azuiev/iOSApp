//
//  AZFBLoginViewController.m
//  iOSApp
//
//  Created by Aleksey Zuiev on 07/09/2017.
//  Copyright © 2017 Aleksey Zuiev. All rights reserved.
//

#import "AZFBLoginViewController.h"
#import "AZFBFriendsViewController.h"
#import "AZFBLoginContext.h"

@interface AZFBLoginViewController ()

@end

@implementation AZFBLoginViewController

- (IBAction)loginToFacebook:(id)sender {
    NSLog(@"Test");
    AZFBLoginContext *context = [AZFBLoginContext contextWithViewController:self];
    
    [context execute];
}

- (void)presentChildController {
    AZFBFriendsViewController *controller = [AZFBFriendsViewController new];
    controller.friends = nil;
    [self presentViewController:controller animated:YES completion:nil];
}

@end
