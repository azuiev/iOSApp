//
//  AZUsersView.h
//  iOSApp
//
//  Created by Aleksey Zuiev on 11/07/2017.
//  Copyright © 2017 Aleksey Zuiev. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "AZUser.h"

@interface AZUsersView : UIView
@property (nonatomic, strong) IBOutlet UITableView    *tableView;

- (void)setEditing:(BOOL)editing animated:(BOOL)animated;

- (AZUser *)getUserByIndexPath:(NSIndexPath *)indexPath;
@end