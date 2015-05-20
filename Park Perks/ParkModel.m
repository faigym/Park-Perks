//
//  ParkModel.m
//  Park Perks
//
//  Created by Douglas Voss on 5/19/15.
//  Copyright (c) 2015 Skyler Clark. All rights reserved.
//

#import "ParkModel.h"
#import "Perk.h"

@implementation ParkModel : NSObject

// dynamic means I provide getter and setter methods
/*
@dynamic name;
@dynamic address;
@dynamic latitude;
@dynamic longitude;
@dynamic phoneNumber;
@dynamic perks;
*/

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.name = @"Empty Name";
        self.address = @"123 Nowhere Street";
        self.latitude = 0.0;
        self.longitude = 0.0;
        self.phoneNumber = @"111-1111";
        self.perks = [[NSMutableArray alloc] init];
    }
    return self;
}

- (BOOL)saveToDataBase
{    
    /*[self saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if (succeeded) {
            // The object has been saved.
            NSLog(@"save in background success!");
            [[NSNotificationCenter defaultCenter] postNotificationName:kSaveDoneNotification object:nil];
        } else {
            // There was a problem, check error.description
            NSLog(@"save in background failure!");
     }
    }];*/
    NSLog(@"save placeholder");
    
    return @YES;
}

- (NSString *)description
{
    NSMutableString *mutStr = [[NSMutableString alloc] init];
    [mutStr appendString:[NSString stringWithFormat:@"Name: %@\n", self.name]];
    [mutStr appendString:[NSString stringWithFormat:@"Address: %@\n", self.address]];
    [mutStr appendString:[NSString stringWithFormat:@"Latitude: %f\n", self.latitude]];
    [mutStr appendString:[NSString stringWithFormat:@"Longitude: %f\n", self.longitude]];
    [mutStr appendString:[NSString stringWithFormat:@"Phone Number: %@\n", self.phoneNumber]];
    [mutStr appendString:[NSString stringWithFormat:@"Perks:\n"]];
    for (Perk *perk in self.perks)
    {
        [mutStr appendString:[perk toString]];
        [mutStr appendString:@"\n"];
    }
    return mutStr;
}

@end
