//
//  AZMacros.h
//  iOSApp
//
//  Created by Aleksey Zuiev on 11/07/2017.
//  Copyright © 2017 Aleksey Zuiev. All rights reserved.
//


#define AZBaseViewProperty(propertyName, viewClass) \
    @property (nonatomic, readonly) viewClass    *propertyName;

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

#define AZWeakify(object) __weak __typeof(object) AZWeakified_##object = object

#define AZStrongify(object) \
    AZPragmaClangPushExpression("clang diagnostic ignored \"-Wshadow\"") \
    __strong __typeof(object) object = AZWeakified_##object \
    AZPragmaClangDiagnosticPop

#define AZEmptyProperty

#define AZStrongifyAndReturnIfNil(object) \
    AZStrongifyAndReturnValueIfNil(object, AZEmptyProperty);

#define AZStrongifyAndReturnNilIfNil(object) \
    AZStrongifyAndReturnValueIfNil(object, nil);

#define AZStrongifyAndReturnValueIfNil(object, returnValue) \
    if (!object) { \
        return returnValue; \
    } \
    AZStrongify(object)

#define AZPragmaClangDiagnosticPush _Pragma ("clang diagnostic push");
#define AZPragmaClangDiagnosticPop _Pragma ("clang diagnostic pop");
#define AZPragmaClangPushExpression(key) \
    AZPragmaClangDiagnosticPush; \
    _Pragma(key)
