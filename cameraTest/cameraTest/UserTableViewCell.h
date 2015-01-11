//
//  UserTableViewCell.h
//  cameraTest
//
//  Created by Michael Chen on 1/11/15.
//  Copyright (c) 2015 Michael Chen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UserTableViewCell : UITableViewController <UITableViewDelegate, UITableViewDataSource>

@property (strong, nonatomic) IBOutlet NSString *name;


@end
