//
//  AZImageModel.h
//  iOSApp
//
//  Created by Aleksey Zuiev on 16/07/2017.
//  Copyright © 2017 Aleksey Zuiev. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "AZModel.h"

@interface AZImageModel : AZModel 
@property (nonatomic, readonly) UIImage     *image;
@property (nonatomic, readonly) NSString    *imageName;

- (instancetype)initWithName:(NSString *)imageName;

@end
