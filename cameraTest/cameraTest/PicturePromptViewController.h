//
//  PicturePromptViewController.h
//  cameraTest
//
//  Created by Michael Chen on 1/10/15.
//  Copyright (c) 2015 Michael Chen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PicturePromptViewController : UIViewController
@property (strong, nonatomic) IBOutlet UILabel *picturePromptLabel;
- (IBAction)picturePromptButton:(id)sender;

@end
