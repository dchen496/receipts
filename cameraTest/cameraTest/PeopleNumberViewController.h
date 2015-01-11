//
//  PeopleNumberViewController.h
//  cameraTest
//
//  Created by Michael Chen on 1/10/15.
//  Copyright (c) 2015 Michael Chen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MobileCoreServices/MobileCoreServices.h>
#import <TesseractOCR/TesseractOCR.h>
#import <GPUIMage.h>

@interface PeopleNumberViewController : UIViewController

- (IBAction)maxNumber:(id)sender;

@property BOOL newMedia;

@property (strong, nonatomic) IBOutlet UITextField *numberOfPeople;

@property (strong, nonatomic) IBOutlet UIButton *toNameInputButtom;


@end

extern int current;
extern int max;

