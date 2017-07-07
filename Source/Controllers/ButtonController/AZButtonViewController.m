//
//  AZButtonViewController.m
//  iOSApp
//
//  Created by Aleksey Zuiev on 07/07/2017.
//  Copyright © 2017 Aleksey Zuiev. All rights reserved.
//

#import "AZButtonViewController.h"

#import "AZButtonView.h"

@interface AZButtonViewController ()
@property (nonatomic, strong) AZButtonView *buttonView;

@end

@implementation AZButtonViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIButton *button = self.button;
    CALayer *layer = button.layer;
    layer.borderWidth = 1;
    layer.cornerRadius = 10;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
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
