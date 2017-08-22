//
//  AZLoadingView.m
//  iOSApp
//
//  Created by Aleksey Zuiev on 10/08/2017.
//  Copyright © 2017 Aleksey Zuiev. All rights reserved.
//

#import "AZLoadingView.h"
#import "AZImageModel.h"

@interface AZLoadingView ()
@property (nonatomic, assign) BOOL visible;

@end

@implementation AZLoadingView

#pragma mark -
#pragma mark Class Methods

+ (instancetype)viewWithSuperview:(UIView *)view {
    return [[self alloc] initWithSuperview:view];
}

- (instancetype)initWithSuperview:(UIView *)view {
    self = [super initWithFrame:view.bounds];
    if (self) {
        self.visible = YES;
        
        [self addAsSubview:view];
    }
    
    return self;
}

#pragma mark -
#pragma mark Public Methods

- (void)addAsSubview:(UIView *)view {
    self.frame = view.bounds;
    [view addSubview:self];
}

- (void)setVisible:(BOOL)visible {
    [self setVisible:visible anymated:YES withCompletionHandler:nil];
}

- (void)setVisible:(BOOL)visible anymated:(BOOL)anymated {
     [self setVisible:visible anymated:anymated withCompletionHandler:nil];
}

- (void)    setVisible:(BOOL)visible
              anymated:(BOOL)anymated
 withCompletionHandler:(void(^)(BOOL))completionHandler
{
    if (_visible != visible) {
        _visible = visible;
    }
    
    void(^anymationBlock)() = nil;
    if (visible) {
        anymationBlock=^ {
            [self.activityIndicator startAnimating];
            self.alpha = 0.0;
            self.alpha = 1.0;
        };
    } else {
        anymationBlock=^ {
            self.alpha = 1.0;
            self.alpha = 0.0;
        };
    }
    
    [UIView animateWithDuration:anymated ? 1.0 : 0.0
                     animations:anymationBlock
                     completion:completionHandler];
}

@end
