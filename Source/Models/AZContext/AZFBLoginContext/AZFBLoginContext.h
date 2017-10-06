//
//  AZFBLoginContext.h
//  iOSApp
//
//  Created by Aleksey Zuiev on 07/09/2017.
//  Copyright © 2017 Aleksey Zuiev. All rights reserved.
//

#import "AZContext.h"
#import "AZFBUserModel.h"

@class FBSDKAccessToken;

@interface AZFBLoginContext : AZContext
@property (nonatomic, readonly) FBSDKAccessToken    *accessToken;

- (void)logout;

@end
