//
//  Receipts.h
//  cameraTest
//
//  Created by Douglas Chen on 1/10/15.
//  Copyright (c) 2015 Michael Chen. All rights reserved.
//

#ifndef cameraTest_Receipts_h
#define cameraTest_Receipts_h


NSArray *parseReceipt(NSString *input);
double getPrice(NSArray *input, NSString *word);
NSArray *removeExtraLines(NSArray *input);

#endif
