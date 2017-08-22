//
//  AZView.h
//  iOSApp
//
//  Created by Aleksey Zuiev on 22/08/2017.
//  Copyright © 2017 Aleksey Zuiev. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "AZModel.h"

#import "AZLoadingView.h"

@interface AZView : UIView <AZModelObserver>
@property (nonatomic, strong) AZLoadingView *loadingView;

@end
