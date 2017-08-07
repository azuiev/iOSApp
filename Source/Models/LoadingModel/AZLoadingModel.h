//
//  AZLoadingModel
//  iOSApp
//
//  Created by Aleksey Zuiev on 03/08/2017.
//  Copyright © 2017 Aleksey Zuiev. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "AZObservableObject.h"

@class AZLoadingModel;

typedef NS_ENUM(NSUInteger, AZLoadingModelState) {
    AZModelDidLoad,
    AZModelWillLoad,
    AZModelDidUnload,
    AZModelDidFailLoad
};

@protocol AZLoadingModelObserver <NSObject>

@optional
- (void)modelDidBecameLoaded:(AZLoadingModel *)loadingModel;
- (void)modelDidBecameLoading:(AZLoadingModel *)loadingModel;
- (void)modelDidBecameUnloaded:(AZLoadingModel *)loadingModel;
- (void)modelDidBecameFailedLoading:(AZLoadingModel *)loadingModel;

@end

@interface AZLoadingModel : AZObservableObject <NSCoding>
@property (nonatomic, readonly) id  object;

- (void)load;
- (void)save;
- (void)dump;

//methods for subclassing purposes
- (id)performLoading;

@end
