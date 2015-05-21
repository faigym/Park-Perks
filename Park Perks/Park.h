//
//  Park.h
//  Park Perks
//
//  Created by Douglas Voss on 5/20/15.
//  Copyright (c) 2015 Skyler Clark. All rights reserved.
//

#import <Parse/Parse.h>
#import "Constants.h"

@interface Park : PFObject <PFSubclassing>

@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *street;
@property (nonatomic, strong) NSString *city;
@property (nonatomic, strong) NSString *zipCode;
@property (nonatomic, strong) NSString *state;
@property (nonatomic, assign) CLLocation *location;
@property (nonatomic, assign) double latitude;
@property (nonatomic, assign) double longitude;
@property (nonatomic, strong) NSString *phoneNumber;
@property (nonatomic, assign) NSNumber *rating;
@property (nonatomic, strong) NSMutableArray *perks;

+ (NSString *)parseClassName;
- (NSString *)description;
- (void)saveToDatabase;

@end
