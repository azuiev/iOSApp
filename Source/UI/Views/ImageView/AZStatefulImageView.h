//
//  AZStatefulImageView.h
//  iOSApp
//
//  Created by Aleksey Zuiev on 28/07/2017.
//  Copyright © 2017 Aleksey Zuiev. All rights reserved.
//

#import "AZImageView.h"

@interface AZStatefulImageView : AZImageView
@property (nonatomic, strong) IBOutlet UIActivityIndicatorView  *activityIndicator;

@end
