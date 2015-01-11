//
//  FoodTableViewCell.m
//  cameraTest
//
//  Created by Michael Chen on 1/10/15.
//  Copyright (c) 2015 Michael Chen. All rights reserved.
//

#import "FoodTableViewCell.h"

@implementation FoodTableViewCell

- (void)awakeFromNib {
    // Initialization code
}
- (FoodTableViewCell *) makeCell: (NSMutableArray *) array {
    FoodTableViewCell *cell;
//    [FoodTableView dequeueReusableCellWithIdentifier:@"FoodTableViewCell"];
    // then set the properties for the class.
    cell.name = array[0];
    cell.price = array[1];
    cell.user = @"";
    return cell;
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
