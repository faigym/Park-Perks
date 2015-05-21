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

@property (nonatomic, strong) NSString *fourSquareObjectId;
@property (nonatomic, strong) NSNumber *rating;
@property (nonatomic, strong) NSMutableArray *perks;

+ (NSString *)parseClassName;

- (NSString *)description;
- (void)saveToDatabase;

@end
