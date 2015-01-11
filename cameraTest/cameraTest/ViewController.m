//
//  ViewController.m
//  cameraTest
//
//  Created by Michael Chen on 1/10/15.
//  Copyright (c) 2015 Michael Chen. All rights reserved.
//

#import "ViewController.h"
#include <string.h>
#import <Venmo-iOS-SDK/Venmo.h>

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

NSMutableArray *names;
int current = 1;
int max = 0;

- (IBAction)maxNumber:(id)sender {
    max = [_numberOfPeople.text intValue];
}

- (IBAction)finishedEnteringNames:(id)sender {
    
}

- (IBAction)nextName:(id)sender {
    [self makeNames: current upTo: max];
    
}

- (void) makeNames: (int) counter upTo: (int) max {
    
    if (counter == max) {
        [_enterNextName removeTarget:self action:@selector(nextName:) forControlEvents:UIControlEventTouchUpInside];
        
        [_enterNextName addTarget: self action: @selector(finishedEnteringNames:) forControlEvents: UIControlEventTouchUpInside];
        
        
        
    } else {
        names[counter] = _personName.text;
        
        NSMutableString *personNumber = [NSMutableString stringWithFormat:@"%d",counter + 1];
        NSMutableString *nameLabel = [NSMutableString stringWithString:@"Please enter the name of person "];
        [nameLabel appendString: personNumber];
        _personName.text = [NSMutableString stringWithFormat: @""];
        _namePrompt.text = nameLabel;
        current += 1;
    }
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
    //UIImage *filteredImage = [orientedImage blackAndWhite];
    
    tesseract.image = filteredImage;
    [tesseract recognize];
    NSLog(@"%@", [tesseract recognizedText]);
    NSArray *receipt = parseReceipt([tesseract recognizedText]);
    NSLog(@"%@", receipt);
    for(NSArray *line in receipt) {
        NSLog(@"item=%@, price=%@", [line objectAtIndex: 0], [line objectAtIndex: 1]);
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
        NSMutableArray *item = [[NSMutableArray alloc] init];
        double price = 0.0;
        int has_price = 0;
        int quantity = 1;
        int has_quantity = 0;
        
        NSArray *words = [line componentsSeparatedByString:@" "];

        for(NSString *word in words) {
            NSString *word2 = [word stringByReplacingOccurrencesOfString:@"," withString:@"."];
            const char *w = [word2 UTF8String];
            double tmp;
            if(sscanf(w, "%lf", &tmp) >= 1) {
                if(strchr(w, '.')) {
                    price = tmp;
                    has_price++;
                    continue;
                } else {
                    if(quantity <= 0) {
                        break;
                    } else {
                        quantity = tmp;
                        has_quantity++;
                        continue;
                    }
                }
            }
            int has_letter = 0;
            for(int i = 0; w[i] != '\0'; i++) {
                if(isalpha(w[i])) {
                    has_letter = 1;
                    break;
                }
            }
            if(!has_letter)
                continue;
            [item addObject: word];

        }
        
        if(has_quantity > 1)
            continue;
        if(has_price != 1)
            continue;
        
        NSString *name = [item componentsJoinedByString:@" "];
        NSNumber *priceobj = [NSNumber numberWithDouble: price];
        for(int i = 0; i < quantity; i++) {
            NSArray *line = @[name, priceobj];
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
