//
//  ParksWithPerksQuery.m
//  Park Perks
//
//  Created by Douglas Voss on 5/22/15.
//  Copyright (c) 2015 Skyler Clark. All rights reserved.
//

#import "ParksWithPerksQuery.h"
#import "Foursquare2.h"
#import "Constants.h"
#import "Park.h"
#import <Parse/Parse.h>
#import "ParkPFObject.h"

@implementation ParksWithPerksQuery : NSObject

-(void)queryForPerks:(NSArray *)perkArr latitude:(double)latitude longitude:(double)longitude radius:(double)radius;
{
    self.searchPerksArr = perkArr;
    
    NSNumber *numVenues = @3;
    [Foursquare2
     venueSearchNearByLatitude:[NSNumber numberWithDouble:latitude]
     longitude:[NSNumber numberWithDouble:longitude]
     query:nil
     limit:numVenues
     intent:intentCheckin
     radius:[NSNumber numberWithDouble:radius]
     categoryId:kFoursquareCategoryParkID
     callback:^(BOOL success, id result){
         if (success) {
             NSDictionary *dic = result;
             //NSLog(@"dic=%@", dic);
             NSArray *venues = [dic valueForKeyPath:@"response.venues"];
             NSLog(@"foursquare query success");
             //NSLog(@"%@", venues);
             
             self.parksInAreaArr = [NSMutableArray new];
             for (int i=0; i < [venues count]; i++)
             {
                 Park *park = [Park new];
                 
                 NSString *string;
                 
                 string=[venues[i] valueForKeyPath:@"id"];
                 if (string) { park.foursquareObjectId = string;} else {park.foursquareObjectId = @"No data for Foursquare Object ID.";}
                 
                 string=[venues[i] valueForKeyPath:@"name"];
                 if (string) { park.name = string;} else {park.name = @"No data for name.";}
                 
                 string=[venues[i] valueForKeyPath:@"location.address"];
                 if (string) { park.street = string;} else {park.street = @"No data for street.";}
                 
                 string=[venues[i] valueForKeyPath:@"location.city"];
                 if (string) { park.city = string;} else {park.city = @"No data for city.";}
                 
                 string=[venues[i] valueForKeyPath:@"location.postalCode"];
                 if (string) { park.zipCode = string;} else {park.zipCode = @"No data for zip code.";}
                 
                 string=[venues[i] valueForKeyPath:@"location.state"];
                 if (string) { park.state = string;} else {park.state = @"No data for state.";}
                 
                 string=[venues[i] valueForKeyPath:@"location.distance"];
                 if (string) { park.distance = [string floatValue];} else {park.distance = MAXFLOAT;}
                 
                 string=[venues[i] valueForKeyPath:@"location.lat"];
                 if (string) { park.latitude = [string floatValue];} else {park.latitude = MAXFLOAT;}
                 
                 string=[venues[i] valueForKeyPath:@"location.lng"];
                 if (string) { park.longitude = [string floatValue];} else {park.longitude = MAXFLOAT;}
                 
                 string=[venues[i] valueForKeyPath:@"contact.formattedPhone"];
                 if (string) { park.phoneNumber = string;} else {park.phoneNumber = @"No data for phone number.";}
                 
                 [self.parksInAreaArr addObject:park];
             }
         } else {
             NSLog(@"%@",result);
         }
         
         NSMutableArray *idArr = [NSMutableArray new];
         for (int i=0; i<[self.parksInAreaArr count]; i++) {
             //NSLog(@"Park %d: \n%@", i, self.parksInAreaArr[i]);
             Park *park = self.parksInAreaArr[i];
             [idArr addObject:park.foursquareObjectId];
             //NSLog(@"park[%d]==%@", i, park);
         }
         //NSLog(@"idArr==%@", idArr);
         //NSLog(@"searchPerks==%@", self.searchPerksArr);
         PFQuery *query = [ParkPFObject query];
         [query whereKey:@"foursquareObjectId" containedIn:idArr];
         [query whereKey:@"perks" containsAllObjectsInArray:self.searchPerksArr];
         [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
             NSLog(@"perk query success");
             //NSLog(@"objects: %@", objects);
             //NSLog(@"found %ld objects", objects.count);
             
             NSMutableArray *objIdArr = [NSMutableArray new];
             for (int i=0; i<[self.parksInAreaArr count]; i++) {
                 Park *park = self.parksInAreaArr[i];
                 [objIdArr addObject:park.foursquareObjectId];
             }
             
             self.filteredParksArr = [NSMutableArray new];
             self.filteredParksPFObjIdArr = [NSMutableArray new];
             for (int i=0; i<[objects count]; i++)
             {
                 ParkPFObject *parkPFObj = objects[i];

                 NSUInteger parkIndex = [objIdArr indexOfObject:parkPFObj.foursquareObjectId];
                 
                 if (parkIndex < [self.parksInAreaArr count]) {
                     Park *park = self.parksInAreaArr[parkIndex];
                     park.rating = [parkPFObj.rating integerValue];
                     park.perks = [NSMutableArray new];
                     for (int i=0; i<[parkPFObj.perks count]; i++)
                     {
                         //NSLog(@"perks[%d]==%@", i, parkPFObj.perks[i]);
                         [park.perks addObject:parkPFObj.perks[i]];
                     }
                     [self.filteredParksArr addObject:park];
                     [self.filteredParksPFObjIdArr addObject:parkPFObj.objectId];
                 }
             }
             
             /*for (int i=0; i<[self.filteredParksArr count]; i++)
             {
                 Park *park = self.filteredParksArr[i];
                 NSLog(@"park[%d].perks=%@", i, park.perks);
             }*/
             [self.delegate queryCompleted];
         }];
     }];
    
}

-(void)testDelegate {
    if (self.delegate && [self.delegate respondsToSelector:@selector(queryCompleted)]) {
        [self.delegate queryCompleted];
    }
}

@end
