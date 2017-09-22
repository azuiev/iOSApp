//
//  AZUserModel.h
//  iOSApp
//
//  Created by Aleksey Zuiev on 14/07/2017.
//  Copyright © 2017 Aleksey Zuiev. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "AZImageModel.h"

@interface AZUserModel : NSObject
@property (nonatomic, copy) NSString            *name;
@property (nonatomic, copy) NSString            *surname;
@property (nonatomic, readonly) NSString        *fullName;
@property (nonatomic, readonly) AZImageModel    *smallUserPicture;

@end
