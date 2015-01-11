//
//  Users.m
//  cameraTest
//
//  Created by Douglas Chen on 1/10/15.
//  Copyright (c) 2015 Michael Chen. All rights reserved.
//

#import <Foundation/Foundation.h>

NSMutableArray *users = 0;
int maxUsers = 0;
int currentUser = 1;

void addUser(NSMutableArray *input, NSString *name, BOOL isVenmo) {
    if(!input) {
        input = [[NSMutableArray alloc] init];
    }
    [input addObject: @[name, [NSNumber numberWithBool: isVenmo]]];
}

NSString *getUsername(NSMutableArray *input, int index) {
    if(index < 0)
        return @"";
    return [[input objectAtIndex: index] objectAtIndex: 0];
}

BOOL getUserVenmo(NSMutableArray *input, int index) {
    if(index < 0)
        return NO;
    return [[[input objectAtIndex: index] objectAtIndex: 1] boolValue];
}