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
        sharedInstance.locationManager.delegate = sharedInstance;
        
        if ([sharedInstance.locationManager respondsToSelector:@selector(requestWhenInUseAuthorization)]) {
            [sharedInstance.locationManager requestWhenInUseAuthorization];
        }
        [sharedInstance.locationManager startUpdatingLocation];
        //NSLog(@"currentlocation singleton created: locationManager=%@", sharedInstance.locationManager);
    });
    return sharedInstance;
}

// Delegate method from the CLLocationManagerDelegate protocol.
- (void)locationManager:(CLLocationManager *)manager
     didUpdateLocations:(NSArray *)locations {
    
    //NSLog(@"locationManager got called");
    // just get location once on startup.
    self.location = (CLLocation *)locations[0];
    //NSLog(@"count=%d; latitude %+.6f, longitude %+.6f\n",
    //      [locations count],
    //      self.location.coordinate.latitude,
    //      self.location.coordinate.longitude);
    if ((self.location.coordinate.latitude != 0) && (self.location.coordinate.longitude != 0))
    {
        [self.locationManager stopUpdatingLocation];
    }
    [self.delegate oneShotLocationUpdateCompleted];
}

- (void)startUpdatingLocation
{
    [self.locationManager startUpdatingLocation];
}

@end
