//
//  FoursquareQuery.h
//  Park Perks
//
//  Created by Douglas Voss on 5/22/15.
//  Copyright (c) 2015 Skyler Clark. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Park.h"

@protocol FoursquareQueryDelegate;

@interface FoursquareQuery : NSObject

@property (nonatomic, weak) id <FoursquareQueryDelegate> delegate;
@property (nonatomic, strong) NSArray *parkArr;

@end

@protocol FoursquareQueryDelegate

- (void)parseDataBaseQuery:(NSArray *)objIdArr;

@end
