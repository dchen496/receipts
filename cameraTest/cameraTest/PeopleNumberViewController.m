//
//  PeopleNumberViewController.m
//  cameraTest
//
//  Created by Michael Chen on 1/10/15.
//  Copyright (c) 2015 Michael Chen. All rights reserved.
//

#import "PeopleNumberViewController.h"
#import "PicturePromptViewController.h"
#import <Venmo-iOS-SDK/Venmo.h>
#import "Receipts.h"

@implementation PeopleNumberViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
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

- (IBAction)maxNumber:(id)sender {
    max = [_numberOfPeople.text intValue];
}

@end


int current = 1;
int max = 0;
