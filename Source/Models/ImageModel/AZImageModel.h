//
//  AZImageModel.h
//  iOSApp
//
//  Created by Aleksey Zuiev on 16/07/2017.
//  Copyright © 2017 Aleksey Zuiev. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "AZLoadingModel.h"

@interface AZImageModel : AZLoadingModel 
@property (nonatomic, readonly) UIImage     *image;

- (instancetype)initWithName:(NSString *)name;

@end
