//
//  Park.h
//  Park Perks
//
//  Created by Douglas Voss on 5/20/15.
//  Copyright (c) 2015 Skyler Clark. All rights reserved.
//

#import <Parse/Parse.h>
#import "Constants.h"
#import <MapKit/Mapkit.h>

@interface Park : NSObject <MKAnnotation>

@property(nonatomic, readonly, copy) NSString *title;
@property(nonatomic, readonly, copy) NSString *subtitle;
@property (nonatomic, strong) NSString *foursquareObjectId;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *street;
@property (nonatomic, strong) NSString *city;
@property (nonatomic, strong) NSString *zipCode;
@property (nonatomic, strong) NSString *state;
@property (nonatomic, assign) double distance;
@property (nonatomic, assign) double latitude;
@property (nonatomic, assign) double longitude;
//@property (nonatomic, assign) CLLocationCoordinate2D coordinate;
@property (nonatomic, readonly) CLLocationCoordinate2D coordinate;
@property (nonatomic, strong) NSString *phoneNumber;
@property (nonatomic, assign) NSInteger rating;
@property (nonatomic, strong) NSMutableArray *perks;

- (instancetype)initWithTitle:(NSString *)title subtitle:(NSString *)subtitle coordinate:(CLLocationCoordinate2D)coordinate;
- (NSString *)description;
- (void)setCoordinate:(CLLocationCoordinate2D)newCoordinate;

@end
