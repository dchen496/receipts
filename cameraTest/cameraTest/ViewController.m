//
//  ViewController.m
//  cameraTest
//
//  Created by Michael Chen on 1/10/15.
//  Copyright (c) 2015 Michael Chen. All rights reserved.
//

#import "ViewController.h"
#include <string.h>

@interface ViewController (CameraDelegateMethods)

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)useCamera:(id)sender {
        if ([UIImagePickerController isSourceTypeAvailable:
             UIImagePickerControllerSourceTypeCamera])
        {
            UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
            imagePicker.delegate = self;
            imagePicker.sourceType =
            UIImagePickerControllerSourceTypeCamera;
            imagePicker.mediaTypes = @[(NSString *) kUTTypeImage];
            imagePicker.allowsEditing = NO;
            [self presentViewController:imagePicker animated:YES completion:nil];
            _newMedia = YES;
        }
}

- (void)useCameraRoll:(id)sender
    {
        if ([UIImagePickerController isSourceTypeAvailable:
             UIImagePickerControllerSourceTypeSavedPhotosAlbum])
        {
            UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
            imagePicker.delegate = self;
            imagePicker.sourceType =
            UIImagePickerControllerSourceTypePhotoLibrary;
            imagePicker.mediaTypes = @[(NSString *) kUTTypeImage];
            imagePicker.allowsEditing = NO;
            [self presentViewController:imagePicker animated:YES completion:nil];
            _newMedia = NO;
        }
}

#pragma mark -
#pragma mark UIImagePickerControllerDelegate

-(void)imagePickerController:(UIImagePickerController *)picker
didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    NSString *mediaType = info[UIImagePickerControllerMediaType];
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
    Tesseract *tesseract = [[Tesseract alloc] initWithLanguage:@"eng"];
    tesseract.delegate = self;
    UIImage *inputImage = info[UIImagePickerControllerOriginalImage];
    UIImage *orientedImage = [self fixImage:inputImage];
    
    GPUImageAdaptiveThresholdFilter *stillImageFilter = [[GPUImageAdaptiveThresholdFilter alloc] init];
    stillImageFilter.blurRadiusInPixels = 20.0;
    
    UIImage *filteredImage = [stillImageFilter imageByFilteringImage:orientedImage];
    
    tesseract.image = filteredImage;
    [tesseract recognize];
    NSLog(@"%@", [tesseract recognizedText]);
    NSArray *receipt = parseReceipt([tesseract recognizedText]);
    NSLog(@"%@", receipt);
    for(NSArray *line in receipt) {
        NSLog(@"%@ %@", [line objectAtIndex: 0], [line objectAtIndex: 1]);
    }
    NSLog(@"width=%f height=%f", filteredImage.size.width, filteredImage.size.height);

    if ([mediaType isEqualToString:(NSString *)kUTTypeImage]) {
        UIImage *image = info[UIImagePickerControllerOriginalImage];
        
        _imageView.image = filteredImage;
        
        if (_newMedia)
            UIImageWriteToSavedPhotosAlbum(image,
                                           self,
                                           @selector(image:finishedSavingWithError:contextInfo:),
                                           nil);
    }
}

NSArray *parseReceipt(NSString *input) {
    NSMutableArray *out = [[NSMutableArray alloc] init];
    
    NSArray *lines = [input componentsSeparatedByString:@"\n"];
    for (NSString *line in lines) {
        NSMutableArray *item;
        double price = 0.0;
        int quantity = 1;
        
        NSArray *words = [line componentsSeparatedByString:@" "];
        
        for(NSString *word in words) {
            const char *w = [word UTF8String];
            double tmp;
            if(sscanf(w, "%lf", &tmp) >= 1) {
                if(strchr(w, '.')) {
                    price = tmp;
                    continue;
                } else {
                    if(quantity > 0) {
                        quantity = tmp;
                        continue;
                    }
                }
            }
            int has_letter = 0;
            for(int i = 0; w[i]; i++) {
                if(isalpha(i)) {
                    has_letter = 1;
                    break;
                }
            }
            if(!has_letter)
                continue;
            [item addObject: word];
        }
        
        for(int i = 0; i < quantity; i++) {
            NSArray *line = @[[item componentsJoinedByString:@" "], [NSNumber numberWithInt: quantity]];
            [out addObject: line];
        }
    }
    return [NSArray arrayWithArray: out];
}

-(UIImage *) fixImage:(UIImage *)image {
    if (image.imageOrientation == UIImageOrientationUp) return image;
    
    UIGraphicsBeginImageContextWithOptions(image.size, NO, image.scale);
    [image drawInRect:(CGRect){0, 0, image.size}];
    UIImage *normalizedImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return normalizedImage;
}

-(void)image:(UIImage *)image
finishedSavingWithError:(NSError *)error
 contextInfo:(void *)contextInfo
{
    if (error) {
        UIAlertView *alert = [[UIAlertView alloc]
                              initWithTitle: @"Save failed"
                              message: @"Failed to save image"
                              delegate: nil
                              cancelButtonTitle:@"OK"
                              otherButtonTitles:nil];
        [alert show];
    }
}





@end
