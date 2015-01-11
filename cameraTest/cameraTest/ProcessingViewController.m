//
//  ProcessingViewController.m
//  cameraTest
//
//  Created by Douglas Chen on 1/11/15.
//  Copyright (c) 2015 Michael Chen. All rights reserved.
//

#import "ProcessingViewController.h"
#import "Receipts.h"
#import <GPUIMage.h>

@interface ProcessingViewController ()

@end

@implementation ProcessingViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    _filteredImageView.image = _inputImage;

    dispatch_async(dispatch_get_main_queue(), ^{
        
        UIImage *orientedImage = [self fixImage:_inputImage];
        
        GPUImageAdaptiveThresholdFilter *stillImageFilter = [[GPUImageAdaptiveThresholdFilter alloc] init];
        stillImageFilter.blurRadiusInPixels = 20.0;
        
        // I have no idea
#if TARGET_IPHONE_SIMULATOR
        UIImage *filteredImage = [orientedImage blackAndWhite];
#else
        UIImage *filteredImage = [stillImageFilter imageByFilteringImage:orientedImage];
#endif
        _filteredImageView.image = filteredImage;

        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_LOW, 0), ^{
            
            Tesseract *tesseract = [[Tesseract alloc] initWithLanguage:@"eng"];
            tesseract.delegate = self;
            tesseract.image = filteredImage;
            [tesseract recognize];
            NSLog(@"%@", [tesseract recognizedText]);
            receipt = parseReceipt([tesseract recognizedText]);
            filteredReceipt = removeExtraLines(receipt);
            NSLog(@"%@", receipt);
            for(NSArray *line in receipt) {
                NSLog(@"item=%@, price=%@", [line objectAtIndex: 0], [line objectAtIndex: 1]);
            }
            NSLog(@"width=%f height=%f", filteredImage.size.width, filteredImage.size.height);
            
            dispatch_async(dispatch_get_main_queue(), ^{
                UIStoryboard*  sb = [UIStoryboard storyboardWithName:@"Main"                                          bundle:nil];
                UIViewController* vc = [sb instantiateViewControllerWithIdentifier:@"UserTableViewCell"];
                
                [self.navigationController pushViewController:vc animated:YES];
            });
        });
    });
}

-(UIImage *) fixImage:(UIImage *)image {
    if (image.imageOrientation == UIImageOrientationUp) return image;
    
    UIGraphicsBeginImageContextWithOptions(image.size, NO, image.scale);
    [image drawInRect:(CGRect){0, 0, image.size}];
    UIImage *normalizedImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return normalizedImage;
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
