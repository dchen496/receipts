//
//  Users.m
//  cameraTest
//
//  Created by Douglas Chen on 1/10/15.
//  Copyright (c) 2015 Michael Chen. All rights reserved.
//

#import <Foundation/Foundation.h>

NSMutableArray *names = 0;
int maxUsers = 0;
int currentUser = 1;

void addUser(NSString *name) {
    if(!names) {
        names = [[NSMutableArray alloc] init];
    }
    [names addObject: name];
}
