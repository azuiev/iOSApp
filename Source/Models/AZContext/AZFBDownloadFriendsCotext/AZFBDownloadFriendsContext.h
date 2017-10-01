//
//  AZFBDownloadFriendsContext.h
//  iOSApp
//
//  Created by Aleksey Zuiev on 13/09/2017.
//  Copyright © 2017 Aleksey Zuiev. All rights reserved.
//

#import "AZGetContext.h"

#import "AZFBFriendsViewController.h"

@interface AZFBDownloadFriendsContext : AZGetContext
@property (nonatomic, strong) AZFBFriendsViewController *controller;

@end
