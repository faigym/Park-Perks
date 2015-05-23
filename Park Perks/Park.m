//
//  Park.m
//  Park Perks
//
//  Created by Douglas Voss on 5/20/15.
//  Copyright (c) 2015 Skyler Clark. All rights reserved.
//

#import "Park.h"

@implementation Park : NSObject

- (NSString *)description
{
    NSMutableString *mutStr = [NSMutableString new];
    
    [mutStr appendString:[NSString stringWithFormat:@"Foursquare object id: %@\r", self.foursquareObjectId]];
    [mutStr appendString:[NSString stringWithFormat:@"name: %@\r", self.name]];
    [mutStr appendString:[NSString stringWithFormat:@"street: %@\r", self.street]];
    [mutStr appendString:[NSString stringWithFormat:@"city: %@\r", self.city]];
    [mutStr appendString:[NSString stringWithFormat:@"zip: %@\r", self.zipCode]];
    [mutStr appendString:[NSString stringWithFormat:@"state: %@\r", self.state]];
    NSLocale *locale = [NSLocale currentLocale];
    NSString *units = [locale objectForKey: NSLocaleMeasurementSystem] ? @"meters" : @"feet";
    [mutStr appendString:[NSString stringWithFormat:@"distance: %f %@\r", self.distance, units]];
    [mutStr appendString:[NSString stringWithFormat:@"latitude: %f\r", self.latitude]];
    [mutStr appendString:[NSString stringWithFormat:@"longitude: %f\r", self.longitude]];
    [mutStr appendString:[NSString stringWithFormat:@"phone number: %@\r", self.phoneNumber]];
    if (self.rating >= 0) {
        [mutStr appendString:[NSString stringWithFormat:@"rating: %ld\r", self.rating]];
    } else {
        [mutStr appendString:[NSString stringWithFormat:@"rating: no data\r"]];
    }
    [mutStr appendString:[NSString stringWithFormat:@"perks: \r"]];
    for (NSString *str in self.perks) {
        [mutStr appendString:[NSString stringWithFormat:@"%@\r", str]];
    }
    
    return mutStr;
}

@end
