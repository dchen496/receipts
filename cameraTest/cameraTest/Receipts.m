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

NSMutableArray *receipt, *filteredReceipt;

NSMutableArray *parseReceipt(NSString *input) {
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
                if(strchr(w, '.') && !strchr(w, '%')) {
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
            // strip out nonalphanumeric
            NSCharacterSet *charactersToRemove = [[NSCharacterSet alphanumericCharacterSet] invertedSet];
            NSString *clean = [[word componentsSeparatedByCharactersInSet:charactersToRemove] componentsJoinedByString:@""];
            clean = [clean capitalizedString];
            [item addObject: clean];
        }
        
        if(has_quantity > 1)
            continue;
        if(has_price != 1)
            continue;
        
        NSString *name = [item componentsJoinedByString:@" "];
        price /= quantity;
        NSNumber *priceobj = [NSNumber numberWithDouble: price];
        for(int i = 0; i < quantity; i++) {
            NSMutableArray *line = [NSMutableArray arrayWithObjects: name, priceobj, [NSNumber numberWithInt: -1]];
            [out addObject: line];
        }
    }
    return out;
}

double getPrice(NSArray *input, NSString *word) {
    for(NSArray *entry in input) {
        if([[entry objectAtIndex: 0] rangeOfString:word options: NSCaseInsensitiveSearch ].location != NSNotFound) {
            return [[entry objectAtIndex:1 ] doubleValue];
        }
    }
    return 0.0;
}

double getTotal(NSArray *input) {
    double total = 0.0;
    for(NSArray *entry in input) {
        total += [[entry objectAtIndex:1] doubleValue];
    }
    return total;
}

double getUserTotal(NSArray *input, int user) {
    double total = 0.0;
    for(NSArray *entry in input) {
        int u = [[entry objectAtIndex:2] intValue];
        if(u == user)
            total += [[entry objectAtIndex:1] doubleValue];
    }
    return total;
}

double adjustForTaxes(double user, double total, double taxes) {
    return user * (1.0 + taxes / total);
}

NSMutableArray *removeExtraLines(NSArray *input) {
    NSArray *remove = @[@"tax", @"total", @"gratuity", @"tip",
                        @"purchase", @"balance", @"visa", @"payment",
                        @"change", @"mastercard", @"subtotal", @"amount",
                        @"take out", @"counter", @"cash", @"sub-total"];
    NSMutableArray *out = [[NSMutableArray alloc] init];
    for(NSArray *entry in input) {
        BOOL bad = NO;
        NSString *name = [entry objectAtIndex: 0];
        for(NSString *word in remove) {
            if([name rangeOfString:word options:NSCaseInsensitiveSearch].location != NSNotFound) {
                bad = YES;
                break;
            }
        }
        if(bad) {
            continue;
        }
        [out addObject: entry];
    }
    return out;
}

void assignUserToLine(NSMutableArray *input, int line, int user) {
    [[input objectAtIndex: line] setObject: [NSNumber numberWithInt: user] atIndex: 2];
}

int getLineUser(NSMutableArray *input, int line) {
    return (int) [[[input objectAtIndex: line] objectAtIndex: 2] integerValue];
}