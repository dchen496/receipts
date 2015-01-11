//
//  NameEnterViewController.m
//  cameraTest
//
//  Created by Michael Chen on 1/10/15.
//  Copyright (c) 2015 Michael Chen. All rights reserved.
//

#import "NameEnterViewController.h"
#import "PeopleNumberViewController.h"
#import "Users.h"

@implementation NameEnterViewController

- (IBAction)nextName:(id)sender {
    [self nextUser:sender isVenmo:NO];
}

- (IBAction)nextVenmoId:(id)sender {
    [self nextUser:sender isVenmo:YES];
}

- (IBAction)nextUser:(id)sender isVenmo:(BOOL)venmo {
    if(currentUser <= 1)
        users = [[NSMutableArray alloc] init];
    addUser(users, _personName.text, venmo);
    
    NSMutableString *personNumber = [NSMutableString stringWithFormat:@"%d",currentUser + 1];
    NSMutableString *nameLabel = [NSMutableString stringWithString:@"Venmo ID of person "];
    [nameLabel appendString: personNumber];
    _personName.text = [NSMutableString stringWithFormat: @""];
    _namePrompt.text = nameLabel;
    currentUser += 1;
    
    if (currentUser > maxUsers) {
        UIStoryboard*  sb = [UIStoryboard storyboardWithName:@"Main"
                                                      bundle:nil];
        UIViewController* vc = [sb instantiateViewControllerWithIdentifier:@"PictureViewController"];
        
        [self.navigationController pushViewController:vc animated:YES];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    // Create the colors
    UIColor *darkOp =
    [UIColor colorWithRed:0.00f green:0.75f blue:2.45f alpha:1.0];
    UIColor *lightOp =
    [UIColor colorWithRed:0.00f green:0.75f blue:2.45f alpha:0.05];
    
    // Create the gradient
    CAGradientLayer *gradient = [CAGradientLayer layer];
    
    // Set colors
    gradient.colors = [NSArray arrayWithObjects:
                       (id)lightOp.CGColor,
                       (id)darkOp.CGColor,
                       nil];
    
    // Set bounds
    gradient.frame = self.view.bounds;
    
    // Add the gradient to the view
    [self.view.layer insertSublayer:gradient atIndex:0];
}

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
