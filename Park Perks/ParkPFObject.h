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
@property (nonatomic, strong) NSNumber *rating;
@property (nonatomic, strong) NSArray *perks;

+ (NSString *)parseClassName;

- (NSString *)description;
- (void)saveToDatabase;

@end
