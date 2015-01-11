//
//  TableViewController.h
//  cameraTest
//
//  Created by Michael Chen on 1/10/15.
//  Copyright (c) 2015 Michael Chen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TableViewController : UITableViewController <UITableViewDelegate, UITableViewDataSource>


@property (strong, nonatomic) IBOutlet UILabel *tableTitle;

@property (strong, nonatomic) IBOutlet UITableView *tableView;

@end
