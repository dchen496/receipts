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
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)maxNumber:(id)sender {
    max = [_numberOfPeople.text intValue];
}

@end


NSMutableArray *names;
int current = 1;
int max = 0;
