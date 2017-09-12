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
@property (nonatomic, weak) AZFBLoginContext    *context;
@end

@implementation AZFBLoginViewController

#pragma mark -
#pragma mark Initialization and deallocation

- (instancetype)init {
    self = [super init];
    if (self) {
        self.context = [AZFBLoginContext contextWithViewController:self];
    }
    
    return self;
}

- (void)viewDidAppear:(BOOL)animated {
    if ([self.context alreadyLogged]) {
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
    controller.friends = [AZFBUsersModel new];
    [self presentViewController:controller animated:YES completion:nil];
    
}

@end
