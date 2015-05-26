//
//  CurrentLocation.h
//  Park Perks
//
//  Created by Douglas Voss on 5/25/15.
//  Copyright (c) 2015 Skyler Clark. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

@interface CurrentLocation : NSObject <CLLocationManagerDelegate>

@property (strong, nonatomic) CLLocation *location;
@property (strong, nonatomic) CLLocationManager *locationManager;

+ (instancetype)sharedInstance;

@end
