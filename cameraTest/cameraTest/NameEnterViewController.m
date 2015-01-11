//
//  NameEnterViewController.m
//  cameraTest
//
//  Created by Michael Chen on 1/10/15.
//  Copyright (c) 2015 Michael Chen. All rights reserved.
//

#import "NameEnterViewController.h"
#import "PeopleNumberViewController.h"
#import "PicturePromptViewController.h"

@implementation NameEnterViewController

- (IBAction)finishedEnteringNames:(id)sender {
    UIStoryboard*  sb = [UIStoryboard storyboardWithName:@"Main"
                                                  bundle:nil];
    UIViewController* vc = [sb instantiateViewControllerWithIdentifier:@"PicturePromptViewController"];

    [self.navigationController pushViewController:vc animated:YES];
    
}


- (IBAction)nextName:(id)sender {
    names[current] = _personName.text;
    
    NSMutableString *personNumber = [NSMutableString stringWithFormat:@"%d",current + 1];
    NSMutableString *nameLabel = [NSMutableString stringWithString:@"Please enter the name of person "];
    [nameLabel appendString: personNumber];
    _personName.text = [NSMutableString stringWithFormat: @""];
    _namePrompt.text = nameLabel;
    current += 1;
    
    if (current == max) {
        [_enterNextName removeTarget:self action:@selector(nextName:) forControlEvents:UIControlEventTouchUpInside];
        
        [_enterNextName addTarget: self action: @selector(finishedEnteringNames:) forControlEvents: UIControlEventTouchUpInside];
    }
    if (current > max) {
        [self finishedEnteringNames:sender];
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
