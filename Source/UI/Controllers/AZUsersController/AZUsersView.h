//
//  AZUsersView.h
//  iOSApp
//
//  Created by Aleksey Zuiev on 11/07/2017.
//  Copyright © 2017 Aleksey Zuiev. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "AZView.h"

@interface AZUsersView : AZView
@property (nonatomic, strong) IBOutlet UITableView              *tableView;

- (void)changeEditMode;

@end
