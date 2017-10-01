//
//  AZViewConstants.h
//  iOSApp
//
//  Created by Aleksey Zuiev on 02/08/2017.
//  Copyright © 2017 Aleksey Zuiev. All rights reserved.
//

#import <UIKit/UIKit.h>

static const UIViewAutoresizing AZViewResizableWithFixedPosition = UIViewAutoresizingFlexibleLeftMargin
                        | UIViewAutoresizingFlexibleWidth
                        | UIViewAutoresizingFlexibleRightMargin
                        | UIViewAutoresizingFlexibleTopMargin
                        | UIViewAutoresizingFlexibleHeight
                        | UIViewAutoresizingFlexibleBottomMargin;

static const UIViewAutoresizing AZViewFixedPosition = UIViewAutoresizingFlexibleLeftMargin
                        | UIViewAutoresizingFlexibleRightMargin
                        | UIViewAutoresizingFlexibleTopMargin
                        | UIViewAutoresizingFlexibleBottomMargin;

static const UIViewAutoresizing AZViewResizable = UIViewAutoresizingFlexibleWidth
                        | UIViewAutoresizingFlexibleHeight;
