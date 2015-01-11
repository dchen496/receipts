//
//  Receipts.m
//  cameraTest
//
//  Created by Douglas Chen on 1/10/15.
//  Copyright (c) 2015 Michael Chen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Receipts.h"
#include <string.h>


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


