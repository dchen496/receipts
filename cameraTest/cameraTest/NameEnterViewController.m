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
    
    if (current >= max) {
        [_enterNextName removeTarget:self action:@selector(nextName:) forControlEvents:UIControlEventTouchUpInside];
        
        [_enterNextName addTarget: self action: @selector(finishedEnteringNames:) forControlEvents: UIControlEventTouchUpInside];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
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
