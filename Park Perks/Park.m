//
//  Park.m
//  Park Perks
//
//  Created by Douglas Voss on 5/20/15.
//  Copyright (c) 2015 Skyler Clark. All rights reserved.
//

#import "Park.h"

@interface Park()

@property(nonatomic, readwrite, copy) NSString *title;
@property(nonatomic, readwrite, copy) NSString *subtitle;
@property(nonatomic, readwrite) CLLocationCoordinate2D coordinate;

@end

@implementation Park : NSObject

- (instancetype)initWithTitle:(NSString *)title subtitle:(NSString *)subtitle coordinate:(CLLocationCoordinate2D)coordinate
{
    self = [super init];
    if (self) {
        self.title = title;
        self.subtitle = subtitle;
        self.coordinate = coordinate;
    }
    return self;
}

- (NSString *)description
{
    NSMutableString *mutStr = [NSMutableString new];
    
    [mutStr appendString:[NSString stringWithFormat:@"Foursquare object id: %@\r", self.foursquareObjectId]];
    [mutStr appendString:[NSString stringWithFormat:@"name: %@\r", self.name]];
    [mutStr appendString:[NSString stringWithFormat:@"street: %@\r", self.street]];
    [mutStr appendString:[NSString stringWithFormat:@"city: %@\r", self.city]];
    [mutStr appendString:[NSString stringWithFormat:@"zip: %@\r", self.zipCode]];
    [mutStr appendString:[NSString stringWithFormat:@"state: %@\r", self.state]];
    NSString *units = [[NSLocale currentLocale] objectForKey: NSLocaleMeasurementSystem];
    if ([units isEqualToString:@"Metric"]) {
        [mutStr appendString:[NSString stringWithFormat:@"distance: %.1f kilometers\r", self.distance/1000.0]];
    } else if ([units isEqualToString:@"U.S."]) {
        [mutStr appendString:[NSString stringWithFormat:@"distance: %.1f miles\r", (self.distance/1000.0)*(1.0/KM_PER_MILE)]];
    } else {
        [mutStr appendString:[NSString stringWithFormat:@"distance: %f unknown units\r", self.distance]];
    }
    
    [mutStr appendString:[NSString stringWithFormat:@"latitude: %f\r", self.latitude]];
    [mutStr appendString:[NSString stringWithFormat:@"longitude: %f\r", self.longitude]];
    [mutStr appendString:[NSString stringWithFormat:@"phone number: %@\r", self.phoneNumber]];
    if (self.rating >= 0) {
        [mutStr appendString:[NSString stringWithFormat:@"rating: %ld\r", (long)self.rating]];
    } else {
        [mutStr appendString:[NSString stringWithFormat:@"rating: no data\r"]];
    }
    [mutStr appendString:[NSString stringWithFormat:@"perks: \r"]];
    for (NSString *str in self.perks) {
        [mutStr appendString:[NSString stringWithFormat:@"%@\r", str]];
    }
    
    return mutStr;
}

- (void)setCoordinate:(CLLocationCoordinate2D)newCoordinate
{
    _coordinate = newCoordinate;
}

@end
