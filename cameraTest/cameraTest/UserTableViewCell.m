//
//  UserTableViewCell.m
//  cameraTest
//
//  Created by Michael Chen on 1/11/15.
//  Copyright (c) 2015 Michael Chen. All rights reserved.
//

#import "UserTableViewCell.h"
#import "Receipts.h"
#import "TableViewController.h"
#import "Users.h"

@implementation UserTableViewCell
{
NSArray *tableData;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    NSLog(@"%@", users);
    // Initialize table data
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [users count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *simpleTableIdentifier = @"User List";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTableIdentifier];
    }
    
    cell.textLabel.text = getUsername(users, indexPath.row);
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UIStoryboard*  sb = [UIStoryboard storyboardWithName:@"Main"                                          bundle:nil];
    UIViewController* vc = [sb instantiateViewControllerWithIdentifier:@"TableViewController"];
    
    [self.navigationController pushViewController:vc animated:YES];
}



//- (void)awakeFromNib {
//    // Initialization code
//}
//
//- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
//    [super setSelected:selected animated:animated];
//
//    // Configure the view for the selected state
//}
//
//
//}

@end
