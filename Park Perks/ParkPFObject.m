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
@dynamic rating;
@dynamic perks;
@dynamic images;

+ (NSString *)parseClassName
{
    return @"Park";
}

@end
