//
//  Park.h
//  Park Perks
//
//  Created by Douglas Voss on 5/20/15.
//  Copyright (c) 2015 Skyler Clark. All rights reserved.
//

#import <Parse/Parse.h>
#import "Constants.h"

@interface ParkPFObject : PFObject <PFSubclassing>

@property (nonatomic, strong) NSString *foursquareObjectId;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, assign) double latitude;
@property (nonatomic, assign) double longitude;
@property (nonatomic, strong) NSString *phoneNumber;
@property (nonatomic, strong) NSString *street;
@property (nonatomic, strong) NSString *city;
@property (nonatomic, strong) NSString *state;
@property (nonatomic, strong) NSString *zipCode;
@property (nonatomic, strong) NSNumber *rating;
@property (nonatomic, strong) NSArray *perks;
@property (nonatomic, strong) PFFile *thumbnail;

+ (NSString *)parseClassName;

- (NSString *)description;

@end
