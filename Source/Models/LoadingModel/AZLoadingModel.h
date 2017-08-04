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
    AZModelUnloaded,
    AZModelLoading,
    AZModelLoaded,
    AZModelFailedLoading
};

@protocol AZLoadingModelObserver <NSObject>

@optional
- (void)modelDidBecameUnloaded:(AZLoadingModel *)loadingModel;
- (void)modelDidBecameLoading:(AZLoadingModel *)loadingModel;
- (void)modelDidBecameLoaded:(AZLoadingModel *)loadingModel;
- (void)modelDidBecameFailedLoading:(AZLoadingModel *)loadingModel;

@end

@interface AZLoadingModel : AZObservableObject <NSCoding>
@property (nonatomic, readonly) id  object;

+ (instancetype)modelWithURL:(NSURL *)url;

- (instancetype)initWithURL:(NSURL *)url;

- (void)load;
- (void)save;
- (void)dump;


//methods for subclassing purposes
- (void)saveToURL:(NSURL *)url;
- (id)modelWithURL:(NSURL *)url;

@end
