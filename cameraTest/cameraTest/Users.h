//
//  Users.h
//  cameraTest
//
//  Created by Douglas Chen on 1/10/15.
//  Copyright (c) 2015 Michael Chen. All rights reserved.
//

#ifndef cameraTest_Users_h
#define cameraTest_Users_h

extern int maxUsers;
extern int currentUser;
extern NSMutableArray *users;

void addUser(NSMutableArray *input, NSString *name, BOOL isVenmo);
NSString *getUser(NSMutableArray *input, int index);
BOOL getUserVenmo(NSMutableArray *input, int index);

#endif
