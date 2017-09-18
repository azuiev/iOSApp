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
#import "AZFBDownloadFriendsContext.h"

@interface AZFBLoginViewController ()
@property (nonatomic, weak) AZFBLoginContext    *context;
@end

@implementation AZFBLoginViewController

#pragma mark -
#pragma mark Initialization and deallocation

- (void)viewDidAppear:(BOOL)animated {
    self.context = [AZFBLoginContext contextWithViewController:self];
    
    if (self.context.accessToken) {
        [self presentChildController];
    }
}

- (IBAction)loginToFacebook:(id)sender {
    NSLog(@"Test");
    AZFBLoginContext *context = [AZFBLoginContext contextWithViewController:self];
    
    [context execute];
}

- (void)presentChildController {
    AZFBFriendsViewController *controller = [AZFBFriendsViewController new];
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:controller];
    //controller.friends = [AZFBUsersModel new];
    [self presentViewController:navigationController animated:YES completion:nil];
    
    [[AZFBDownloadFriendsContext contextWithViewController:controller] execute];
}

@end
