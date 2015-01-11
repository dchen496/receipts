//
//  NameEnterViewController.h
//  cameraTest
//
//  Created by Michael Chen on 1/10/15.
//  Copyright (c) 2015 Michael Chen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PeopleNumberViewController.h"

@interface NameEnterViewController : UIViewController

@property (strong, nonatomic) IBOutlet UILabel *namePrompt;
@property (strong, nonatomic) IBOutlet UITextField *personName;
@property (strong, nonatomic) IBOutlet UIButton *enterNextName;
@property (strong, nonatomic) IBOutlet UITextField *numberOfPeople;

- (IBAction)finishedEnteringNames:(id)sender;
- (IBAction)nextName:(id)sender;

@end
