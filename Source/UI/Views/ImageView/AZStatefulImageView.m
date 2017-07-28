//
//  AZStatefulImageView.m
//  iOSApp
//
//  Created by Aleksey Zuiev on 28/07/2017.
//  Copyright © 2017 Aleksey Zuiev. All rights reserved.
//

#import "AZStatefulImageView.h"

@implementation AZStatefulImageView

- (void)setImageModel:(AZImageModel *)imageModel {
    if (imageModel && imageModel != self.imageModel)  {
        [self.activityIndicator startAnimating];
    }
    
    [super setImageModel:imageModel];
}

- (void)modelDidLoad:(AZImageModel *)model {
    [self.activityIndicator stopAnimating];
    [super modelDidLoad:model];
    
}
@end
