//
//  Receipts.h
//  cameraTest
//
//  Created by Douglas Chen on 1/10/15.
//  Copyright (c) 2015 Michael Chen. All rights reserved.
//

#ifndef cameraTest_Receipts_h
#define cameraTest_Receipts_h

extern NSMutableArray *receipt;

NSMutableArray *parseReceipt(NSString *input);
double getPrice(NSArray *input, NSString *word);
NSMutableArray *removeExtraLines(NSArray *input);
double getTotal(NSArray *input);
double getUserTotal(NSArray *input, int user);
double adjustForTaxes(double user, double total, double taxes);

#endif
