//
//  MembersListViewController.h
//  versus
//
//  Created by Mike Mayo on 12/11/13.
//  Copyright (c) 2013 Mike Mayo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MembersListViewController : UIViewController <UITableViewDataSource, UITableViewDataSource>

@property (strong, nonatomic) IBOutlet UITableView *tableView;

@end
