//
//  TableViewController.m
//  cameraTest
//
//  Created by Michael Chen on 1/10/15.
//  Copyright (c) 2015 Michael Chen. All rights reserved.
//

#import "FinalViewController.h"
#import "Receipts.h"
#import "Users.h"

@implementation FinalViewController
{
    NSArray *tableData;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Initialize table data
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [users count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *simpleTableIdentifier = @"Final List";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:simpleTableIdentifier];
    }
    
    cell.textLabel.text = getUsername(users, indexPath.row);
    double usertotal = getUserTotal(filteredReceipt, indexPath.row);
    double tax = getPrice(receipt, @"tax");
    double total = getTotal(filteredReceipt);
    double adjusted = adjustForTaxes(usertotal, total, tax);
    cell.detailTextLabel.text = [NSString stringWithFormat: @"$%.2f", adjusted];
    return cell;
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
