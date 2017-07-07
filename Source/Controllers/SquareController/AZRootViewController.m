//
//  AZRootViewController.m
//  iOSApp
//
//  Created by Aleksey Zuiev on 30/06/2017.
//  Copyright © 2017 Aleksey Zuiev. All rights reserved.
//

#import "AZRootViewController.h"

#import "AZRootView.h"

@interface AZRootViewController ()
@property (nonatomic, strong) AZRootView    *rootView;

@end

@implementation AZRootViewController

#pragma mark -
#pragma mark Accessors

- (AZRootView *)AZRootView {
    if ([self isViewLoaded] && [self.view isKindOfClass:[AZRootView class]]) {
        return (AZRootView *)self.view;
    }
    
    return nil;
}

- (void)viewDidLoad {
    [super viewDidLoad];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
