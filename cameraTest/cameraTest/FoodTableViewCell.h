//
//  FoodTableViewCell.h
//  cameraTest
//
//  Created by Michael Chen on 1/10/15.
//  Copyright (c) 2015 Michael Chen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FoodTableViewCell : UITableViewCell

@property (strong, nonatomic) IBOutlet NSString *name;
@property (strong, nonatomic) IBOutlet NSNumber *price;
@property (strong, nonatomic) IBOutlet NSString *user;

@end
