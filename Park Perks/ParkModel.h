//
//  ParkModel.h
//  Park Perks
//
//  Created by Douglas Voss on 5/19/15.
//  Copyright (c) 2015 Skyler Clark. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Parse/Parse.h>
#import "Perk.h"

static NSString *kSaveDoneNotification = @"saveDoneNotification";

@interface ParkModel : NSObject

// General Properties
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *address;
@property (nonatomic, assign) double latitude;
@property (nonatomic, assign) double longitude;
@property (nonatomic, strong) NSString *phoneNumber;
@property (nonatomic, strong) NSMutableArray *perks;

- (BOOL)saveToDataBase;

@end
