//
//  CurrentLocation.m
//  Park Perks
//
//  Created by Douglas Voss on 5/25/15.
//  Copyright (c) 2015 Skyler Clark. All rights reserved.
//

#import "CurrentLocation.h"

@implementation CurrentLocation

+ (instancetype) sharedInstance
{
    static CurrentLocation *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[CurrentLocation alloc] init];
        
        sharedInstance.locationManager = [[CLLocationManager alloc] init];
        
        sharedInstance.locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters;
        
        // Set a movement threshold for new events.
        sharedInstance.locationManager.distanceFilter = 500; // meters
        
        sharedInstance.location = [CLLocation new];
        
        if ([sharedInstance.locationManager respondsToSelector:@selector(requestWhenInUseAuthorization)]) {
            [sharedInstance.locationManager requestWhenInUseAuthorization];
        }
        [sharedInstance.locationManager startUpdatingLocation];
        NSLog(@"currentlocation singleton created: locationManager=%@", sharedInstance.locationManager);
    });
    return sharedInstance;
}

@end
