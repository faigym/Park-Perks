//
//  Park.m
//  Park Perks
//
//  Created by Douglas Voss on 5/20/15.
//  Copyright (c) 2015 Skyler Clark. All rights reserved.
//

#import "ParkPFObject.h"

@implementation ParkPFObject

@dynamic foursquareObjectId;
@dynamic name;
@dynamic latitude;
@dynamic longitude;
@dynamic phoneNumber;
@dynamic street;
@dynamic city;
@dynamic state;
@dynamic zipCode;
@dynamic rating;
@dynamic perks;
@dynamic thumbnail;


+ (NSString *)parseClassName
{
    return @"Park";
}

- (NSString *)description
{
    NSMutableString *mutStr = [NSMutableString new];
    [mutStr appendString:[NSString stringWithFormat:@"foursquareObjectId: %@\r", self.foursquareObjectId]];
    [mutStr appendString:[NSString stringWithFormat:@"name: %@\r", self.name]];
    [mutStr appendString:[NSString stringWithFormat:@"latitude: %f\r", self.latitude]];
    [mutStr appendString:[NSString stringWithFormat:@"longitude: %f\r", self.longitude]];
    [mutStr appendString:[NSString stringWithFormat:@"phone number: %@\r",self.phoneNumber]];
    [mutStr appendString:[NSString stringWithFormat:@"street: %@\r",self.street]];
    [mutStr appendString:[NSString stringWithFormat:@"city: %@\r",self.city]];
    [mutStr appendString:[NSString stringWithFormat:@"state: %@\r",self.state]];
    [mutStr appendString:[NSString stringWithFormat:@"longitude: %ld\r", [self.rating integerValue]]];
    for (int i=0; i < [self.perks count]; i++) {
        [mutStr appendString:[NSString stringWithFormat:@"perks[%d]: %@\r", i, self.perks[i]]];
    }
    
    return mutStr;
}

@end
