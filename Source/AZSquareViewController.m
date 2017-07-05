//
//  AZDquareViewController.m
//  iOSApp
//
//  Created by Aleksey Zuiev on 30/06/2017.
//  Copyright © 2017 Aleksey Zuiev. All rights reserved.
//

#import "AZSquareViewController.h"

#import "AZSquareView.h"

@interface AZSquareViewController ()
@property (nonatomic, strong) AZSquareView  *squareView;

@end

@implementation AZSquareViewController

#pragma mark -
#pragma mark Accessors

- (void)setSquare:(AZSquare *)square {
    if (_square != square) {
        _square = square;
    }
    
    self.squareView.square = square;
}

- (AZSquareView *)squareView {
    if ([self isViewLoaded] && [self.view isKindOfClass:[AZSquareView class]]) {
        return (AZSquareView *)self.view;
    }
    
    return nil;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    UIButton *button = self.squareView.buttonNext;
    CALayer *layer = button.layer;
    layer.borderWidth = 1;
    layer.cornerRadius = 10;
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
