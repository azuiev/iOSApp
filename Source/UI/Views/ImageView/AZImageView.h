//
//  AZImageView.h
//  iOSApp
//
//  Created by Aleksey Zuiev on 20/07/2017.
//  Copyright © 2017 Aleksey Zuiev. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "AZImageModel.h"

@interface AZImageView : UIView <AZImageModelObserver>
@property (nonatomic, strong) IBOutlet  UIImageView     *contentImageView;
@property (nonatomic, strong) AZImageModel              *imageModel;

//this is only methods for subclasses. Don not call it directly
- (void)modelDidLoad:(AZImageModel *)model;

@end
