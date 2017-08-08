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

typedef NS_ENUM(NSUInteger, AZModelState) {
    AZModelDidLoad,
    AZModelWillLoad,
    AZModelDidUnload,
    AZModelDidFailLoad,
    AZModelStateCount
};

@protocol AZModelObserver <NSObject>

@optional
- (void)modelDidBecameLoaded:(AZModel *)loadingModel;
- (void)modelDidBecameLoading:(AZModel *)loadingModel;
- (void)modelDidBecameUnloaded:(AZModel *)loadingModel;
- (void)modelDidBecameFailedLoading:(AZModel *)loadingModel;

@end

@interface AZModel : AZObservableObject <NSCoding>
@property (nonatomic, readonly) id  object;

- (void)load;
- (void)save;
- (void)dump;

//methods for subclassing purposes
- (id)performLoading;

@end
