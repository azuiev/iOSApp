//
//  AZMacros.h
//  iOSApp
//
//  Created by Aleksey Zuiev on 11/07/2017.
//  Copyright © 2017 Aleksey Zuiev. All rights reserved.
//

#define AZBaseViewProperty(propertyName, viewClass) \
    @property (nonatomic, strong) viewClass    *propertyName;

#define AZViewGetterSintesize(selector, viewClass) \
    - (viewClass *)selector { \
        if ([self isViewLoaded] && [self.view isKindOfClass:[viewClass class]]) { \
            return (viewClass *)self.view; \
        } \
    \
    return nil; \
}\

#define AZBaseViewControllerWithProperty(viewControllerClass, propertyName, viewClass) \
    @interface viewControllerClass (AZBaseViewController) \
        AZBaseViewProperty(propertyName, viewClass); \
    \
    @end \
    \
    @implementation viewControllerClass (AZBaseViewController) \
    @dynamic propertyName; \
    \
    AZViewGetterSintesize(propertyName, viewClass); \
    \
    @end\
