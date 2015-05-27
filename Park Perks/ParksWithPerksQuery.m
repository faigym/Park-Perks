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
#import "CurrentLocation.h"

@implementation ParksWithPerksQuery : NSObject

-(instancetype)init
{
    self = [super init];
    if (self) {
        self.searchPerksArr = @[];
        self.parksInAreaArr = [NSMutableArray new];
        self.filteredParksArr = [NSMutableArray new];
        self.filteredParksPFObjIdArr = [NSMutableArray new];
    }
    return self;
}

-(void)foursquareQueryForPerks:(NSArray *)perkArr latitude:(double)latitude longitude:(double)longitude radius:(double)radius numResultsLimit:(NSUInteger)numResultsLimit
{
    self.searchPerksArr = perkArr;
    
    /*
     void(^dbBlock)(FDataSnapshot *snapshot);
     dbBlock = ^void(FDataSnapshot *snapshot) {
     self.randomDVQuizQuestion = nil;
     self.randomDVQuizQuestion =
     [[DVQuizQuestion alloc]
     init:snapshot.value[@"question"]
     answerA:snapshot.value[@"answerA"]
     answerB:snapshot.value[@"answerB"]
     answerC:snapshot.value[@"answerC"]
     answerD:snapshot.value[@"answerD"]
     correctIndex:[snapshot.value[@"correctIndex"] integerValue]];
     };*/
    
    /*void(^parseQueryBlock)();
     parseQueryBlock = ^void() {*/
    
    NSNumber *numVenues = [NSNumber numberWithUnsignedInteger:numResultsLimit];
    
    [Foursquare2
     venueSearchNearByLatitude:[NSNumber numberWithDouble:latitude]
     longitude:[NSNumber numberWithDouble:longitude]
     query:nil
     limit:numVenues
     intent:intentCheckin
     radius:[NSNumber numberWithDouble:radius]
     categoryId:kFoursquareCategoryParkID
     callback:^(BOOL success, id result)
     {
         if (success)
         {
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
         }
         else
         {
             NSLog(@"%@",result);
         }
         
         NSMutableArray *idArr = [NSMutableArray new];
         for (int i=0; i<[self.parksInAreaArr count]; i++)
         {
             //NSLog(@"Park %d: \n%@", i, self.parksInAreaArr[i]);
             Park *park = self.parksInAreaArr[i];
             [idArr addObject:park.foursquareObjectId];
             //NSLog(@"park[%d]==%@", i, park);
         }
         //NSLog(@"idArr==%@", idArr);
         //NSLog(@"searchPerks==%@", self.searchPerksArr);
         // only search for perks if there are perks to be searched for, otherwise return the unfiltered parks in area
         if ([self.searchPerksArr count] <= 0)
         {
             self.filteredParksArr = self.parksInAreaArr;
             
             if (self.delegate && [self.delegate respondsToSelector:@selector(queryCompleted)])
             {
                 [self.delegate queryCompleted];
             }
         }
         else
         {
             PFQuery *query = [ParkPFObject query];
             [query whereKey:@"foursquareObjectId" containedIn:idArr];
             [query whereKey:@"perks" containsAllObjectsInArray:self.searchPerksArr];
             [query findObjectsInBackgroundWithBlock:
              ^(NSArray *objects, NSError *error)
              {
                  NSLog(@"perk query success");
                  //NSLog(@"objects: %@", objects);
                  NSLog(@"found %d objects", objects.count);
                  
                  NSMutableArray *objIdArr = [NSMutableArray new];
                  for (int i=0; i<[self.parksInAreaArr count]; i++)
                  {
                      Park *park = self.parksInAreaArr[i];
                      [objIdArr addObject:park.foursquareObjectId];
                  }
                  
                  self.filteredParksArr = [NSMutableArray new];
                  self.filteredParksPFObjIdArr = [NSMutableArray new];
                  for (int i=0; i<[objects count]; i++)
                  {
                      ParkPFObject *parkPFObj = objects[i];
                      
                      NSUInteger parkIndex = [objIdArr indexOfObject:parkPFObj.foursquareObjectId];
                      
                      if (parkIndex < [self.parksInAreaArr count])
                      {
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
         }
     }];
}

-(void)parseOnlyQueryForPerks:(NSArray *)perkArr city:(NSString *)city state:(NSString *)state
{
    PFQuery *query = [ParkPFObject query];
    self.searchPerksArr = perkArr;
    self.searchCity = city;
    self.searchState = state;
    [query whereKey:@"city" equalTo:self.searchCity];
    [query whereKey:@"state" equalTo:self.searchState];
    [query whereKey:@"perks" containsAllObjectsInArray:self.searchPerksArr];
    [query findObjectsInBackgroundWithBlock:
     ^(NSArray *objects, NSError *error)
     {
         //NSLog(@"perk query success");
         //NSLog(@"objects: %@", objects);
         //NSLog(@"found %ld objects", objects.count);
         
         self.parksInAreaArr = [NSMutableArray new];
         self.filteredParksArr = [NSMutableArray new];
         self.filteredParksPFObjIdArr = [NSMutableArray new];
         for (int i=0; i<[objects count]; i++)
         {
             ParkPFObject *parkPFObj = objects[i];
             
             Park *park = [Park new];
             park.name = parkPFObj.name;
             park.rating = [parkPFObj.rating integerValue];
             park.city = parkPFObj.city;
             park.state = parkPFObj.state;
             park.latitude = parkPFObj.latitude;
             park.longitude = parkPFObj.longitude;
             
             CLLocationCoordinate2D destCoord;
             destCoord.latitude = park.latitude;
             destCoord.longitude = park.longitude;
             
             CLLocationCoordinate2D srcCoord=[CurrentLocation sharedInstance].location.coordinate;
             NSLog(@"srcCoord.latitude=%f longitude=%f", srcCoord.latitude, srcCoord.longitude);
             //srcCoord.latitude = 40.65928505282439;
             //srcCoord.longitude = -111.8822121620178;
             
             park.distance = [self haversineFormulaDistanceWithDestCoord:destCoord srcCoord:srcCoord];
             park.perks = [NSMutableArray new];
             for (int i=0; i<[parkPFObj.perks count]; i++)
             {
                 //NSLog(@"perks[%d]==%@", i, parkPFObj.perks[i]);
                 [park.perks addObject:parkPFObj.perks[i]];
             }
             [self.filteredParksArr addObject:park];
             [self.filteredParksPFObjIdArr addObject:parkPFObj.objectId];
             
         }
         self.parksInAreaArr = self.filteredParksArr;
         
         /*for (int i=0; i<[self.filteredParksArr count]; i++)
          {
          Park *park = self.filteredParksArr[i];
          NSLog(@"park[%d].perks=%@", i, park.perks);
          }*/
         if (self.delegate && [self.delegate respondsToSelector:@selector(queryCompleted)])
         {
             [self.delegate queryCompleted];
         }
     }];
}

-(double)haversineFormulaDistanceWithDestCoord:(CLLocationCoordinate2D)destCoord srcCoord:(CLLocationCoordinate2D)srcCoord
{
    /* This is the method recommended for calculating short distances by Bob Chamberlain (rgc@jpl.nasa.gov) of Caltech and NASA's Jet Propulsion Laboratory as described on the U.S. Census Bureau Web site.
     
     dlon = lon2 - lon1
     dlat = lat2 - lat1
     a = (sin(dlat/2))^2 + cos(lat1) * cos(lat2) * (sin(dlon/2))^2
     c = 2 * atan2( sqrt(a), sqrt(1-a) )
     d = R * c (where R is the radius of the Earth) */
    
    double dlon = destCoord.longitude - srcCoord.longitude;
    double dlat = destCoord.latitude - srcCoord.latitude;
    double deg2rad = M_PI / 180.0;
    double a = pow(sin((dlat/2.0)*deg2rad),2) + (cos(srcCoord.latitude*deg2rad) * cos(destCoord.latitude*deg2rad) * pow(sin((dlon/2)*deg2rad),2));
    double c = 2 * atan2( sqrt(a), sqrt(1-a) );
    //double R = 3963.1676; // Radius of earth in miles
    double R = 6378100; // Radius of earth in meters
    double distance = R * c; //(where R is the radius of the Earth)
    
    return distance;
}

-(NSArray *)queryForImagesPointingToPFObjId:(NSString *)pfObjIdStr
{
    NSMutableArray *pfImageViewMutArr = [NSMutableArray new];
    
    ParkPFObject *pointer = [ParkPFObject objectWithoutDataWithClassName:@"Park" objectId:pfObjIdStr];
    
    PFQuery *imageQuery = [PFQuery queryWithClassName:@"ParkImage"];
    [imageQuery whereKey:@"pointerToPark" equalTo:pointer];
    [imageQuery findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        NSLog(@"image query completed; objects: %@", objects);
        NSLog(@"found %ld objects", [objects count]);
        for (int i=0; i<[objects count]; i++) {
            PFObject *pfObj = objects[i];
            PFFile *file = pfObj[@"ImageFile"];
            PFImageView *pfImageView = [PFImageView new];
            pfImageView.file = file;
            pfImageView.frame = CGRectMake(30, 40, 120, 120);
            [pfImageView loadInBackground];
            [pfImageViewMutArr addObject:pfImageView];
            /*[file getDataInBackgroundWithBlock:^(NSData *result, NSError *error) {
                //NSLog(@"NSData==%@", result);
                NSLog(@"data in background block fired.");
                UIImage *image = [UIImage imageWithData:result];
                NSLog(@"image==%@", image);
                self.imageView1 = [[UIImageView alloc] initWithImage:image];
                self.imageView1.frame = CGRectMake(15, 30, 160, 160);
            }];*/

        }
    }];
    return pfImageViewMutArr;
}

-(void)testDelegate {
    if (self.delegate && [self.delegate respondsToSelector:@selector(queryCompleted)]) {
        [self.delegate queryCompleted];
    }
}

@end
