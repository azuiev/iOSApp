//
//  AZModel
//  iOSApp
//
//  Created by Aleksey Zuiev on 03/08/2017.
//  Copyright © 2017 Aleksey Zuiev. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "AZObservableObject.h"

@class AZModel;

@protocol AZSave <NSObject>

- (void)save;

@end

typedef NS_ENUM(NSUInteger, AZModelState) {
    AZModelDidUnload,
    AZModelWillLoad,
    AZModelDidLoad,
    AZModelDidFailLoad,
    AZModelStateCount
};

@protocol AZModelObserver <NSObject>

@optional
- (void)modelDidLoad:(AZModel *)model;
- (void)modelWillLoad:(AZModel *)model;
- (void)modelDidUnload:(AZModel *)model;
- (void)modelDidFailLoad:(AZModel *)model;

@end

@interface AZModel : AZObservableObject

- (void)load;

//methods for subclassing purposes
- (void)performLoading;

@end
