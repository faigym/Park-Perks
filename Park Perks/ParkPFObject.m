//
//  Park.m
//  Park Perks
//
//  Created by Douglas Voss on 5/20/15.
//  Copyright (c) 2015 Skyler Clark. All rights reserved.
//

#import "ParkPFObject.h"

@implementation ParkPFObject

@dynamic fourSquareObjectId;
@dynamic rating;
@dynamic perks;

+ (NSString *)parseClassName
{
    return @"Park";
}

@end
