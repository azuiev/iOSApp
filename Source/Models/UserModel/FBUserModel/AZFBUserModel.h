//
//  AZFBUserModel.h
//  iOSApp
//
//  Created by Aleksey Zuiev on 11/09/2017.
//  Copyright © 2017 Aleksey Zuiev. All rights reserved.
//

#import "AZUserModel.h"

@interface AZFBUserModel : AZUserModel
@property (nonatomic, readonly) NSString *userID;

+ (instancetype)userWithID:(NSString *)userID fullName:(NSString *)fullName url:(NSURL *)url;

@end
