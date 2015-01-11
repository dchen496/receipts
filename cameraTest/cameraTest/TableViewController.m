//
//  TableViewController.m
//  cameraTest
//
//  Created by Michael Chen on 1/10/15.
//  Copyright (c) 2015 Michael Chen. All rights reserved.
//

#import "TableViewController.h"
#import "Receipts.h"
#import "Users.h"

@interface TableViewController ()

@end

@implementation TableViewController
{
    NSArray *tableData;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Initialize table data
    tableData = filteredReceipt;
    [_currentUser setTitle: getUsername(users, _userId)];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [tableData count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *simpleTableIdentifier = @"Item List";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:simpleTableIdentifier];
    }
    
    cell.textLabel.text = [[tableData objectAtIndex:indexPath.row] objectAtIndex: 0];
    int u = getLineUser(receipt, indexPath.row);
    NSLog(@"%d %ld %ld", u, _userId, indexPath.row);
    cell.userInteractionEnabled = YES;
    cell.textLabel.enabled = YES;
    cell.detailTextLabel.enabled = YES;
    cell.accessoryType = UITableViewCellAccessoryNone;

    if(u == _userId) {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    } else if(u < 0) {
        cell.accessoryType = UITableViewCellAccessoryNone;
    } else {
        cell.userInteractionEnabled = NO;
        cell.textLabel.enabled = NO;
        cell.detailTextLabel.enabled = NO;
    }
    double price = [[[tableData objectAtIndex:indexPath.row] objectAtIndex: 1] doubleValue];
    cell.detailTextLabel.text = [NSString stringWithFormat: @"$%.2f", price];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    int row = indexPath.row;
    int user = _userId;
    NSLog(@"%d", getLineUser(receipt, row));
    if(getLineUser(receipt, row) < 0) {
        assignUserToLine(receipt, row, user);
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    } else {
        unassignLine(receipt, row);
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    [tableView reloadData];
}



//- (void)viewDidLoad {
//    [super viewDidLoad];
//    // Do any additional setup after loading the view.
//    
//    // Create the colors
//    UIColor *darkOp =
//    [UIColor colorWithRed:0.00f green:0.75f blue:2.45f alpha:1.0];
//    UIColor *lightOp =
//    [UIColor colorWithRed:0.00f green:0.75f blue:2.45f alpha:0.05];
//    
//    // Create the gradient
//    CAGradientLayer *gradient = [CAGradientLayer layer];
//    
//    // Set colors
//    gradient.colors = [NSArray arrayWithObjects:
//                       (id)lightOp.CGColor,
//                       (id)darkOp.CGColor,
//                       nil];
//    
//    // Set bounds
//    gradient.frame = self.view.bounds;
//    
//    // Add the gradient to the view
//    [self.view.layer insertSublayer:gradient atIndex:0];
//}

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
