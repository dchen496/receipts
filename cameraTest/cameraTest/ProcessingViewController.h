//
//  ProcessingViewController.h
//  cameraTest
//
//  Created by Douglas Chen on 1/11/15.
//  Copyright (c) 2015 Michael Chen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <TesseractOCR/TesseractOCR.h>

@interface ProcessingViewController : UIViewController <TesseractDelegate>

@property (strong, nonatomic) UIImage *inputImage;
@property (weak, nonatomic) IBOutlet UIImageView *filteredImageView;

@end
