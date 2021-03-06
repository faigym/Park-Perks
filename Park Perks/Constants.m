//
//  Constants.m
//  Park Perks
//
//  Created by Douglas Voss on 5/20/15.
//  Copyright (c) 2015 Skyler Clark. All rights reserved.
//

#import "Constants.h"
#import "categoryLUTPFObject.h"
#import "ParkPFObject.h"

@interface Constants()

@property (nonatomic, strong, readwrite) categoryLUTPFObject *categoryLUT;
@property (nonatomic, strong, readwrite) NSDictionary *perksForCategoryDict;
@property (nonatomic, strong, readwrite) NSDictionary *categoriesForPerkDict;

@end

@implementation Constants

+ (instancetype) sharedInstance
{
    static Constants *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[Constants alloc] init];
        
        sharedInstance.categoryLUT = [categoryLUTPFObject new];
        PFQuery *query = [categoryLUTPFObject query];
        NSUInteger limit = 1;
        NSUInteger skip = 0;
        [query setLimit: limit];
        [query setSkip: skip];
        [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
            if (objects==nil) {
                NSLog(@"Load of category dictionary from parse database failed.");
            }
            sharedInstance.categoryLUT = objects[0];
            sharedInstance.perksForCategoryDict = sharedInstance.categoryLUT.perksForCategoryDict;
            sharedInstance.categoriesForPerkDict = [sharedInstance reversePerksForCategoryDict:sharedInstance.perksForCategoryDict];
            //NSLog(@"categoryLUT loaded in Singleton Constants");
            //NSLog(@"Categories:%@", sharedInstance.categoryLUT.categoryDict);
            //[[NSNotificationCenter defaultCenter] postNotificationName:kPerkPropLUTLoaded object:nil];
            [sharedInstance.delegate constantsLoaded];
        }];
    });

    return sharedInstance;
}

- (NSDictionary *)reversePerksForCategoryDict:(NSDictionary *)dict
{
    NSMutableDictionary *mutDict = [NSMutableDictionary new];
    
    for (NSString *category in [dict allKeys])
    {
        NSArray *perkArr = [dict valueForKey:category];
        NSMutableArray *categoriesPerPerk;
        for (NSString *perkStr in perkArr)
        {
            categoriesPerPerk = [mutDict objectForKey:perkStr];
            if (!categoriesPerPerk) {
                categoriesPerPerk = [NSMutableArray new];
                [mutDict setValue:categoriesPerPerk forKey:perkStr];
            }
            [categoriesPerPerk addObject:category];
        }
    }
    //NSLog(@"reversed mutDict==%@", mutDict);
    return mutDict;
}

- (NSString *)categoryForTableviewSection:(NSInteger)section
{
    NSArray *categoryArr = [self allCategories];
    if (section >= [categoryArr count])
    {
        return @"Other";
    } else {
        return categoryArr[section];
    }
}

- (NSInteger)numberOfPerksForCategory:(NSString *)category
{
    return [[self.perksForCategoryDict valueForKey:category] count];
}

- (NSInteger)numberOfPerksForTableviewSection:(NSInteger )section
{
    return [self numberOfPerksForCategory:[self categoryForTableviewSection:section]];
}

- (NSArray *)perksForCategory:(NSString *)category
{
    return [self.perksForCategoryDict valueForKey:category];
}

- (NSArray *)perksForTableviewSection:(NSInteger)section
{
    return [self.perksForCategoryDict objectForKey:[self categoryForTableviewSection:section]];
}

- (NSArray *)allCategories
{
    return [self.perksForCategoryDict allKeys];
}

- (NSArray *)allPerks
{
    return [self.categoriesForPerkDict allKeys];
}

// This uploads the parse database for the categoryLUT Class
// The categoryLUT maps categories to one or more perks
//
-(void)remakeCategoryLUT
{
    categoryLUTPFObject *categoryLUT = [categoryLUTPFObject new];
    categoryLUT.perksForCategoryDict =
    @{
      kCategoryPlayground:@[
              kBabySwing,
              kSwings,
              kClimbingNet,
              kClimbingWall,
              kElectronicGameStations,
              kMerryGoRound,
              kMonkeyBars,
              kPlaySystem,
              kRubberMat,
              kSand,
              kSandDigger,
              kSeeSaw,
              kShadedPlayground,
              kSlide,
              kSplashPad,
              kSpringRocker,
              kTireSwing,
              kToddler,
              kWoodChips,
              kZipLine],
      kCategorySports:@[
              kBaseball,
              kSoccerGoals,
              kMultipurposeField,
              kBasketBall,
              kLightedBasketBall,
              kTennis,
              kRaquetBall,
              kVolleyBallCement,
              kVolleyBallSand,
              kBMXPark,
              kSkatePark,
              kDiscGolf,
              kBicycling,
              kHorseShoes,
              kPickleball],
      kCategoryFacilities:@[
              kBathrooms,
              kWaterFountain,
              kElectricity,
              kLighting,
              kDogsAllowed,
              kDogsOffLeashAllowed,
              kShade,
              kRamada,
              kBenches,
              kReservable,
              kParkingLot],
      kCategoryPicnic:@[
              kBBQ,
              kShelter,
              kPavilion,
              kRamada,
              kAlcoholPermit,
              kElectricity,
              kPicnicTables],
      kCategoryExerciseNature:@[
              kWalkingJoggingPath,
              kExerciseEquipment,
              kCreek,
              kPond,
              kArboretum,
              kWildlife,
              kDucks,
              kFishing,
              kHistoryMonuments,
              kShadeTrees,
              kHills],
      kCategoryWater:@[
              kOutdoorPool,
              kWaterSlide,
              kCreek,
              kPond,
              kSplashPad,
              kFishing,
              kWaterFountain,
              kWaterNozzle]
      };
    
    [categoryLUT pinInBackground];
    [categoryLUT saveInBackground];
}

-(void)remakeParkTestDatabase
{
    ParkPFObject *murrayPark = [ParkPFObject new];
    murrayPark.foursquareObjectId = @"4bc0fe774cdfc9b671ee9321";
    murrayPark.name = @"Murray City Park";
    murrayPark.latitude = 40.65928505282439;
    murrayPark.longitude = -111.8822121620178;
    murrayPark.phoneNumber = @"801-264-2614";
    murrayPark.street = @"296 East Murray Park Avenue";
    murrayPark.city = @"Murray";
    murrayPark.state = @"Utah";
    murrayPark.rating = [NSNumber numberWithInt:5];
    murrayPark.perks = @[kPond, kDucks, kMonkeyBars, kToddler, kSand, kOutdoorPool, kWaterSlide, kMultipurposeField, kShadeTrees, kHills, kVolleyBallSand, kExerciseEquipment, kCreek, kLighting, kPavilion, kWaterFountain, kPlaySystem, kSwings, kBabySwing];
    /*murrayPark.images =
    @[
      UIImageJPEGRepresentation([UIImage imageNamed:@"MurrayParkEastPlaysystem.jpg"], 0.5),
      UIImageJPEGRepresentation([UIImage imageNamed:@"MurrayParkElementaryToddlerPlaysystem.jpg"], 0.5),
      UIImageJPEGRepresentation([UIImage imageNamed:@"MurrayParkWestToddlerPlaysystem.jpg"], 0.5),
      UIImageJPEGRepresentation([UIImage imageNamed:@"MurrayParkWestPlaysystem.jpg"], 0.5),
      ];*/
    /*NSData *imageData = UIImageJPEGRepresentation([UIImage imageNamed:@"MurrayParkEastPlaysystem.jpg"], 0.5);
    PFFile *imageFile = [PFFile fileWithName:@"murrayParkEastPlaysystem.jpg" data:imageData];
    murrayPark.pfFileImage = imageFile;*/
    
    [murrayPark pinInBackground];
    [murrayPark saveInBackground];
    
    PFObject *imagePFObj = [PFObject objectWithClassName:@"ParkImage"];
    NSData *imageData = UIImageJPEGRepresentation([UIImage imageNamed:@"MurrayParkEastPlaysystem"], 0.5);
    PFFile *imagePFFile = [PFFile fileWithName:@"MurrayParkEastPlaysystem.jpg" data:imageData];
    imagePFObj[@"ImageFile"] = imagePFFile;
    [imagePFObj setObject:murrayPark forKey:@"pointerToPark"];
    [imagePFObj pinInBackground];
    [imagePFObj saveInBackground];
    
    PFObject *imagePFObj2 = [PFObject objectWithClassName:@"ParkImage"];
    NSData *imageData2 = UIImageJPEGRepresentation([UIImage imageNamed:@"MurrayParkWestPlaysystem"], 0.5);
    PFFile *imagePFFile2 = [PFFile fileWithName:@"MurrayParkWestPlaysystem.jpg" data:imageData2];
    imagePFObj2[@"ImageFile"] = imagePFFile2;
    [imagePFObj2 setObject:murrayPark forKey:@"pointerToPark"];
    [imagePFObj2 pinInBackground];
    [imagePFObj2 saveInBackground];
    
    /*PFQuery *imageQuery = [PFQuery queryWithClassName:@"ParkImage"];
    [imageQuery whereKey:@"pointerToPark" equalTo:murrayPark];
    [imageQuery findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        NSLog(@"image query completed; objects: %@", objects);
        NSLog(@"found %ld objects", objects.count);
     }];*/

    ParkPFObject *friendshipPark = [ParkPFObject new];
    friendshipPark.foursquareObjectId = @"4bf6ab6f5efe2d7f428d6734";
    friendshipPark.name = @"Friendship Park";
    friendshipPark.latitude = 40.645818;
    friendshipPark.longitude = -111.879023;
    friendshipPark.phoneNumber = @"Not available";
    friendshipPark.street = @"5766 Bridlechase Ln";
    friendshipPark.city = @"Murray";
    friendshipPark.state = @"Utah";
    friendshipPark.rating = [NSNumber numberWithInt:3];
    friendshipPark.perks = @[kSand, kMerryGoRound, kToddler, kVolleyBallSand, kSwings, kPavilion, kBaseball, kWalkingJoggingPath,kPlaySystem, kBabySwing];
    //friendshipPark.images = @[];
    [friendshipPark pinInBackground];
    [friendshipPark saveInBackground];
    
    ParkPFObject *southCottonwoodPark = [ParkPFObject new];
    southCottonwoodPark.foursquareObjectId = @"4ad4f28ff964a52080fd20e3";
    southCottonwoodPark.name = @"South Cottonwood Park";
    southCottonwoodPark.latitude = 40.6342;
    southCottonwoodPark.longitude = -111.8617;
    southCottonwoodPark.phoneNumber = @"(385) 468-1755";
    southCottonwoodPark.street = @"6351 South 900 East";
    southCottonwoodPark.city = @"Murray";
    southCottonwoodPark.state = @"Utah";
    southCottonwoodPark.rating = [NSNumber numberWithInt:3];
    southCottonwoodPark.perks = @[kPavilion, kBathrooms, kPicnicTables, kPlaySystem, kShadeTrees];
    //southCottonwoodPark.images = @[];
    [southCottonwoodPark pinInBackground];
    [southCottonwoodPark saveInBackground];
    
    ParkPFObject *rivertonPark = [ParkPFObject new];
    rivertonPark.foursquareObjectId = @"4bd3616a41b9ef3bdb0b00e6";
    rivertonPark.name = @"Riverton City Park";
    rivertonPark.latitude = 40.5181;
    rivertonPark.longitude = -111.9322;
    rivertonPark.phoneNumber = @"(801) 254-0704";
    rivertonPark.street = @"12830 S Redwood Rd";
    rivertonPark.city = @"Riverton";
    rivertonPark.state = @"Utah";
    rivertonPark.rating = [NSNumber numberWithInt:4];
    rivertonPark.perks = @[kHorseShoes, kSkatePark, kPickleball, kPavilion, kPlaySystem, kSwings];
    //rivertonPark.images = @[];
    [rivertonPark pinInBackground];
    [rivertonPark saveInBackground];
    
    ParkPFObject *westFieldDownsPark = [ParkPFObject new];
    westFieldDownsPark.foursquareObjectId = @"4fc6564ce4b0b383d5755dcb";
    westFieldDownsPark.name = @"West Field Downs Park";
    westFieldDownsPark.latitude = 40.5321810769231;
    westFieldDownsPark.longitude = -111.957629;
    westFieldDownsPark.phoneNumber = @"(801) 208-3101";
    westFieldDownsPark.street = @"12075 S 2700 W";
    westFieldDownsPark.city = @"Riverton";
    westFieldDownsPark.state = @"Utah";
    westFieldDownsPark.rating = [NSNumber numberWithInt:4];
    westFieldDownsPark.perks = @[kPlaySystem, kBathrooms, kPavilion, kSoccerGoals];
    //westFieldDownsPark.images = @[];
    [westFieldDownsPark pinInBackground];
    [westFieldDownsPark saveInBackground];
}

-(void)remakeMesaArizonaParkTestDatabase
{
    ParkPFObject *altaMesaPark = [ParkPFObject new];
    altaMesaPark.name = @"Alta Mesa Park";
    altaMesaPark.latitude = 33.449874;
    altaMesaPark.longitude = -111.711141;
    altaMesaPark.phoneNumber = @"(480) 644-2352";
    altaMesaPark.street = @"1910 N Alta Mesa Dr";
    altaMesaPark.city = @"Mesa";
    altaMesaPark.state = @"Arizona";
    altaMesaPark.zipCode = @"85205";
    altaMesaPark.rating = [NSNumber numberWithInt:-1];
    altaMesaPark.perks = @[kBasketBall];
    //altaMesaPark.images = @[];
    [altaMesaPark pinInBackground];
    [altaMesaPark saveInBackground];
    
    ParkPFObject *augustaRanchPark = [ParkPFObject new];
    augustaRanchPark.name = @"Augusta Ranch Park";
    augustaRanchPark.latitude = 33.366883;
    augustaRanchPark.longitude = -111.653403;
    augustaRanchPark.phoneNumber = @"(480) 644-2352";
    augustaRanchPark.street = @"9455 E Neville Ave";
    augustaRanchPark.city = @"Mesa";
    augustaRanchPark.state = @"Arizona";
    augustaRanchPark.zipCode = @"85209";
    augustaRanchPark.rating = [NSNumber numberWithInt:-1];
    augustaRanchPark.perks = @[kSand];
    //augustaRanchPark.images = @[];
    [augustaRanchPark pinInBackground];
    [augustaRanchPark saveInBackground];
    
    ParkPFObject *beverlyPark = [ParkPFObject new];
    beverlyPark.name = @"Beverly Park";
    beverlyPark.latitude = 33.417163;
    beverlyPark.longitude = -111.854381;
    beverlyPark.phoneNumber = @"(480) 644-2011";
    beverlyPark.street = @"115 N Beverly";
    beverlyPark.city = @"Mesa";
    beverlyPark.state = @"Arizona";
    beverlyPark.zipCode = @"85201";
    beverlyPark.rating = [NSNumber numberWithInt:-1];
    beverlyPark.perks = @[kSandDigger];
    //beverlyPark.images = @[];
    [beverlyPark pinInBackground];
    [beverlyPark saveInBackground];
    
    ParkPFObject *candleLightPark = [ParkPFObject new];
    candleLightPark.name = @"Candle Light Park";
    candleLightPark.latitude = 33.443195;
    candleLightPark.longitude = -111.798476;
    candleLightPark.phoneNumber = @"(480) 644-2352";
    candleLightPark.street = @"1540 N Barkley";
    candleLightPark.city = @"Mesa";
    candleLightPark.state = @"Arizona";
    candleLightPark.zipCode = @"85203";
    candleLightPark.rating = [NSNumber numberWithInt:-1];
    candleLightPark.perks = @[kMerryGoRound];
    //candleLightPark.images = @[];
    [candleLightPark pinInBackground];
    [candleLightPark saveInBackground];
    
    ParkPFObject *carriageLanePark = [ParkPFObject new];
    carriageLanePark.name = @"Carriage Lane Park";
    carriageLanePark.latitude = 33.353208;
    carriageLanePark.longitude = -111.722836;
    carriageLanePark.phoneNumber = @"(480) 644-2352";
    carriageLanePark.street = @"3140 S Carriage Ln";
    carriageLanePark.city = @"Mesa";
    carriageLanePark.state = @"Arizona";
    carriageLanePark.zipCode = @"85210";
    carriageLanePark.rating = [NSNumber numberWithInt:-1];
    carriageLanePark.perks = @[kSplashPad];
    //carriageLanePark.images = @[];
    [carriageLanePark pinInBackground];
    [carriageLanePark saveInBackground];
    
    ParkPFObject *chaparrelPark = [ParkPFObject new];
    chaparrelPark.name = @"Chaparrel Park";
    chaparrelPark.latitude = 33.445611;
    chaparrelPark.longitude = -111.787724;
    chaparrelPark.phoneNumber = @"(480) 644-5300";
    chaparrelPark.street = @"1645 N. Gilbert";
    chaparrelPark.city = @"Mesa";
    chaparrelPark.state = @"Arizona";
    chaparrelPark.zipCode = @"85210";
    chaparrelPark.rating = [NSNumber numberWithInt:-1];
    chaparrelPark.perks = @[kMultipurposeField];
    //chaparrelPark.images = @[];
    [chaparrelPark pinInBackground];
    [chaparrelPark saveInBackground];
    
    ParkPFObject *chelseaPark = [ParkPFObject new];
    chelseaPark.name = @"chelsea Park";
    chelseaPark.latitude = 33.4125235;
    chelseaPark.longitude = -111.74504030000003;
    chelseaPark.phoneNumber = @"(480) 644-2352";
    chelseaPark.street = @"145 S 40th St";
    chelseaPark.city = @"Mesa";
    chelseaPark.state = @"Arizona";
    chelseaPark.zipCode = @"85206";
    chelseaPark.rating = [NSNumber numberWithInt:-1];
    chelseaPark.perks = @[];
    //chelseaPark.images = @[];
    [chelseaPark pinInBackground];
    [chelseaPark saveInBackground];
    
    ParkPFObject *countrySidePark = [ParkPFObject new];
    countrySidePark.name = @"Country Side Park";
    countrySidePark.latitude = 33.3944188;
    countrySidePark.longitude = -111.76258559999997;
    countrySidePark.phoneNumber = @"(480) 644-2352";
    countrySidePark.street = @"3130 E Southern Ave";
    countrySidePark.city = @"Mesa";
    countrySidePark.state = @"Arizona";
    countrySidePark.zipCode = @"85204";
    countrySidePark.rating = [NSNumber numberWithInt:-1];
    countrySidePark.perks = @[];
    //countrySidePark.images = @[];
    [countrySidePark pinInBackground];
    [countrySidePark saveInBackground];
    
    ParkPFObject *desertTrailsPark = [ParkPFObject new];
    desertTrailsPark.name = @"Desert Trails Bike Park";
    desertTrailsPark.latitude = 33.4692574;
    desertTrailsPark.longitude = -111.70119890000001;
    desertTrailsPark.phoneNumber = @"";
    desertTrailsPark.street = @"2955 N. Recker Road";
    desertTrailsPark.city = @"Mesa";
    desertTrailsPark.state = @"Arizona";
    desertTrailsPark.zipCode = @"85215";
    desertTrailsPark.rating = [NSNumber numberWithInt:-1];
    desertTrailsPark.perks = @[];
    //desertTrailsPark.images = @[];
    [desertTrailsPark pinInBackground];
    [desertTrailsPark saveInBackground];
    
    ParkPFObject *dobsonRanchPark = [ParkPFObject new];
    dobsonRanchPark.name = @"Dobson Ranch Park";
    dobsonRanchPark.latitude = 33.3717491;
    dobsonRanchPark.longitude = -111.88014880000003;
    dobsonRanchPark.phoneNumber = @"(480) 644-4271";
    dobsonRanchPark.street = @"2359 S Dobson Rd";
    dobsonRanchPark.city = @"Mesa";
    dobsonRanchPark.state = @"Arizona";
    dobsonRanchPark.zipCode = @"85202";
    dobsonRanchPark.rating = [NSNumber numberWithInt:-1];
    dobsonRanchPark.perks = @[];
    //dobsonRanchPark.images = @[];
    [dobsonRanchPark pinInBackground];
    [dobsonRanchPark saveInBackground];
    
    ParkPFObject *eastmarkGreatPark = [ParkPFObject new];
    eastmarkGreatPark.name = @"Eastmark Great Park";
    eastmarkGreatPark.latitude = 33.326149;
    eastmarkGreatPark.longitude = -111.61569280000003	;
    eastmarkGreatPark.phoneNumber = @"(480) 625-3005";
    eastmarkGreatPark.street = @"10100 E. Ray Road";
    eastmarkGreatPark.city = @"Mesa";
    eastmarkGreatPark.state = @"Arizona";
    eastmarkGreatPark.zipCode = @"85212";
    eastmarkGreatPark.rating = [NSNumber numberWithInt:-1];
    eastmarkGreatPark.perks = @[];
    //eastmarkGreatPark.images = @[];
    [eastmarkGreatPark pinInBackground];
    [eastmarkGreatPark saveInBackground];
    
    ParkPFObject *emeraldPark = [ParkPFObject new];
    emeraldPark.name = @"Emerald Park";
    emeraldPark.latitude = 33.3887257;
    emeraldPark.longitude = -111.79690570000002;
    emeraldPark.phoneNumber = @"(480) 644-2352";
    emeraldPark.street = @"1455 S Harris Dr";
    emeraldPark.city = @"Mesa";
    emeraldPark.state = @"Arizona";
    emeraldPark.zipCode = @"85204";
    emeraldPark.rating = [NSNumber numberWithInt:-1];
    emeraldPark.perks = @[];
    //emeraldPark.images = @[];
    [emeraldPark pinInBackground];
    [emeraldPark saveInBackground];
    
    ParkPFObject *enidPark = [ParkPFObject new];
    enidPark.name = @"Enid Park";
    enidPark.latitude = 33.3977239;
    enidPark.longitude = -111.71679699999999;
    enidPark.phoneNumber = @"(480) 644-2011";
    enidPark.street = @"5319 E Enid Ave";
    enidPark.city = @"Mesa";
    enidPark.state = @"Arizona";
    enidPark.zipCode = @"85206";
    enidPark.rating = [NSNumber numberWithInt:-1];
    enidPark.perks = @[];
    //enidPark.images = @[];
    [enidPark pinInBackground];
    [enidPark saveInBackground];
    
    ParkPFObject *ensenadaPark = [ParkPFObject new];
    ensenadaPark.name = @"Ensenada Park";
    ensenadaPark.latitude = 33.4331922;
    ensenadaPark.longitude = -111.69272239999998;
    ensenadaPark.phoneNumber = @"(480) 644-2011";
    ensenadaPark.street = @"6413 E Elmwood St";
    ensenadaPark.city = @"Mesa";
    ensenadaPark.state = @"Arizona";
    ensenadaPark.zipCode = @"85205";
    ensenadaPark.rating = [NSNumber numberWithInt:-1];
    ensenadaPark.perks = @[];
    //ensenadaPark.images = @[];
    [ensenadaPark pinInBackground];
    [ensenadaPark saveInBackground];
    
    ParkPFObject *escobedoPark = [ParkPFObject new];
    escobedoPark.name = @"Escobedo Park";
    escobedoPark.latitude = 33.4259126;
    escobedoPark.longitude = -111.82716210000001;
    escobedoPark.phoneNumber = @"(480) 644-2352";
    escobedoPark.street = @"215 E 6th St";
    escobedoPark.city = @"Mesa";
    escobedoPark.state = @"Arizona";
    escobedoPark.zipCode = @"85201";
    escobedoPark.rating = [NSNumber numberWithInt:-1];
    escobedoPark.perks = @[];
    //escobedoPark.images = @[];
    [escobedoPark pinInBackground];
    [escobedoPark saveInBackground];
    
    ParkPFObject *evergreenPark = [ParkPFObject new];
    evergreenPark.name = @"Evergreen Park";
    evergreenPark.latitude = 33.424641;
    evergreenPark.longitude = -111.83883500000002;
    evergreenPark.phoneNumber = @"(480) 644-2352";
    evergreenPark.street = @"328 W 5th St";
    evergreenPark.city = @"Mesa";
    evergreenPark.state = @"Arizona";
    evergreenPark.zipCode = @"85201";
    evergreenPark.rating = [NSNumber numberWithInt:-1];
    evergreenPark.perks = @[];
    //evergreenPark.images = @[];
    [evergreenPark pinInBackground];
    [evergreenPark saveInBackground];
    
    ParkPFObject *falconFieldPark = [ParkPFObject new];
    falconFieldPark.name = @"Falcon Field Park";
    falconFieldPark.latitude = 33.4563647;
    falconFieldPark.longitude = -111.72783190000001;
    falconFieldPark.phoneNumber = @"(480) 644-2352";
    falconFieldPark.street = @"4800 E Falcon Dr";
    falconFieldPark.city = @"Mesa";
    falconFieldPark.state = @"Arizona";
    falconFieldPark.zipCode = @"85215";
    falconFieldPark.rating = [NSNumber numberWithInt:-1];
    falconFieldPark.perks = @[];
    //falconFieldPark.images = @[];
    [falconFieldPark pinInBackground];
    [falconFieldPark saveInBackground];
    
    ParkPFObject *falconHillPark = [ParkPFObject new];
    falconHillPark.name = @"Falcon Hill Park";
    falconHillPark.latitude = 33.448831;
    falconHillPark.longitude = -111.67464000000001;
    falconHillPark.phoneNumber = @"(480) 644-2352";
    falconHillPark.street = @"7222 E Jensen St";
    falconHillPark.city = @"Mesa";
    falconHillPark.state = @"Arizona";
    falconHillPark.zipCode = @"85207";
    falconHillPark.rating = [NSNumber numberWithInt:-1];
    falconHillPark.perks = @[];
    //falconHillPark.images = @[];
    [falconHillPark pinInBackground];
    [falconHillPark saveInBackground];
    
    ParkPFObject *fitchPark = [ParkPFObject new];
    fitchPark.name = @"Fitch Park";
    fitchPark.latitude = 33.40318330000001;
    fitchPark.longitude = -111.8314901;
    fitchPark.phoneNumber = @"(480) 644-4271";
    fitchPark.street = @"651 N. Center";
    fitchPark.city = @"Mesa";
    fitchPark.state = @"Arizona";
    fitchPark.zipCode = @"85211";
    fitchPark.rating = [NSNumber numberWithInt:-1];
    fitchPark.perks = @[];
    //fitchPark.images = @[];
    [fitchPark pinInBackground];
    [fitchPark saveInBackground];
    
    ParkPFObject *gatewayPark = [ParkPFObject new];
    gatewayPark.name = @"Gateway Park";
    gatewayPark.latitude = 33.414672;
    gatewayPark.longitude = -111.823239	;
    gatewayPark.phoneNumber = @"(480) 644-2011";
    gatewayPark.street = @"315 E Main St";
    gatewayPark.city = @"Mesa";
    gatewayPark.state = @"Arizona";
    gatewayPark.zipCode = @"85201";
    gatewayPark.rating = [NSNumber numberWithInt:-1];
    gatewayPark.perks = @[];
    //gatewayPark.images = @[];
    [gatewayPark pinInBackground];
    [gatewayPark saveInBackground];
    
    ParkPFObject *geneAutryPark = [ParkPFObject new];
    geneAutryPark.name = @"Gene Autry Park";
    geneAutryPark.latitude = 33.4507713;
    geneAutryPark.longitude = -111.74311720000003;
    geneAutryPark.phoneNumber = @"(480) 644-4271";
    geneAutryPark.street = @"4125 E McKellips Rd";
    geneAutryPark.city = @"Mesa";
    geneAutryPark.state = @"Arizona";
    geneAutryPark.zipCode = @"85215";
    geneAutryPark.rating = [NSNumber numberWithInt:-1];
    geneAutryPark.perks = @[];
    //geneAutryPark.images = @[];
    [geneAutryPark pinInBackground];
    [geneAutryPark saveInBackground];
    
    ParkPFObject *goldenHillsPark = [ParkPFObject new];
    goldenHillsPark.name = @"Golden Hills Park";
    goldenHillsPark.latitude = 33.4003014;
    goldenHillsPark.longitude = -111.6589654;
    goldenHillsPark.phoneNumber = @"(480) 644-2011";
    goldenHillsPark.street = @"7253 E Pueblo Ave";
    goldenHillsPark.city = @"Mesa";
    goldenHillsPark.state = @"Arizona";
    goldenHillsPark.zipCode = @"85208";
    goldenHillsPark.rating = [NSNumber numberWithInt:-1];
    goldenHillsPark.perks = @[];
    //goldenHillsPark.images = @[];
    [goldenHillsPark pinInBackground];
    [goldenHillsPark saveInBackground];

    ParkPFObject *greenfieldPark = [ParkPFObject new];
    greenfieldPark.name = @"Greenfield Park";
    greenfieldPark.latitude = 33.4151843;
    greenfieldPark.longitude = -111.8314724;
    greenfieldPark.phoneNumber = @"(480) 644-2352";
    greenfieldPark.street = @"4105 E Diamond Ave";
    greenfieldPark.city = @"Mesa";
    greenfieldPark.state = @"Arizona";
    greenfieldPark.zipCode = @"85206";
    greenfieldPark.rating = [NSNumber numberWithInt:-1];
    greenfieldPark.perks = @[];
    //greenfieldPark.images = @[];
    [greenfieldPark pinInBackground];
    [greenfieldPark saveInBackground];
    
    ParkPFObject *guerreroPark = [ParkPFObject new];
    guerreroPark.name = @"Guerrero Rotary Park";
    guerreroPark.latitude = 33.4005563;
    guerreroPark.longitude = -111.8358313;
    guerreroPark.phoneNumber = @"(480) 644-2011";
    guerreroPark.street = @"205 W 8th Ave";
    guerreroPark.city = @"Mesa";
    guerreroPark.state = @"Arizona";
    guerreroPark.zipCode = @"85210";
    guerreroPark.rating = [NSNumber numberWithInt:-1];
    guerreroPark.perks = @[];
    //guerreroPark.images = @[];
    [guerreroPark pinInBackground];
    [guerreroPark saveInBackground];
    
    ParkPFObject *harmonyPark = [ParkPFObject new];
    harmonyPark.name = @"Harmony Park";
    harmonyPark.latitude = 33.3895563;
    harmonyPark.longitude = -111.7619138;
    harmonyPark.phoneNumber = @"(480) 644-2352";
    harmonyPark.street = @"1434 S 32nd St";
    harmonyPark.city = @"Mesa";
    harmonyPark.state = @"Arizona";
    harmonyPark.zipCode = @"85204";
    harmonyPark.rating = [NSNumber numberWithInt:-1];
    harmonyPark.perks = @[];
    //harmonyPark.images = @[];
    [harmonyPark pinInBackground];
    [harmonyPark saveInBackground];
    
    ParkPFObject *heritagePark = [ParkPFObject new];
    heritagePark.name = @"Heritage Park";
    heritagePark.latitude = 33.3875894;
    heritagePark.longitude = -111.82805000000002;
    heritagePark.phoneNumber = @"(480) 644-2352";
    heritagePark.street = @"1501 S Pima";
    heritagePark.city = @"Mesa";
    heritagePark.state = @"Arizona";
    heritagePark.zipCode = @"85210";
    heritagePark.rating = [NSNumber numberWithInt:-1];
    heritagePark.perks = @[];
    //heritagePark.images = @[];
    [heritagePark pinInBackground];
    [heritagePark saveInBackground];
    
    ParkPFObject *hermosaVistaPark = [ParkPFObject new];
    hermosaVistaPark.name = @"Hermosa Vista Park";
    hermosaVistaPark.latitude = 33.4572205;
    hermosaVistaPark.longitude = -111.77068639999999;
    hermosaVistaPark.phoneNumber = @"(480) 644-2011";
    hermosaVistaPark.street = @"2255 N Lindsay Rd";
    hermosaVistaPark.city = @"Mesa";
    hermosaVistaPark.state = @"Arizona";
    hermosaVistaPark.zipCode = @"85213";
    hermosaVistaPark.rating = [NSNumber numberWithInt:-1];
    hermosaVistaPark.perks = @[];
    //hermosaVistaPark.images = @[];
    [hermosaVistaPark pinInBackground];
    [hermosaVistaPark saveInBackground];
    
    ParkPFObject *holmesPark = [ParkPFObject new];
    holmesPark.name = @"Holmes Park";
    holmesPark.latitude = 33.4572205;
    holmesPark.longitude = -111.73672829999998;
    holmesPark.phoneNumber = @"(480) 644-2352";
    holmesPark.street = @"1450 S Greenfield Rd";
    holmesPark.city = @"Mesa";
    holmesPark.state = @"Arizona";
    holmesPark.zipCode = @"85206";
    holmesPark.rating = [NSNumber numberWithInt:-1];
    holmesPark.perks = @[];
    //holmesPark.images = @[];
    [holmesPark pinInBackground];
    [holmesPark saveInBackground];
    
    ParkPFObject *jeffersonPark = [ParkPFObject new];
    jeffersonPark.name = @"Jefferson Park";
    jeffersonPark.latitude = 33.40979799999999;
    jeffersonPark.longitude = -111.67935299999999;
    jeffersonPark.phoneNumber = @"(480) 644-2352";
    jeffersonPark.street = @"306 S Jefferson Ave";
    jeffersonPark.city = @"Mesa";
    jeffersonPark.state = @"Arizona";
    jeffersonPark.zipCode = @"85208";
    jeffersonPark.rating = [NSNumber numberWithInt:-1];
    jeffersonPark.perks = @[];
    //jeffersonPark.images = @[];
    [jeffersonPark pinInBackground];
    [jeffersonPark saveInBackground];
    
    ParkPFObject *kingsboroughPark = [ParkPFObject new];
    kingsboroughPark.name = @"Kingsborough Park";
    kingsboroughPark.latitude = 33.3890028;
    kingsboroughPark.longitude = -111.7816277;
    kingsboroughPark.phoneNumber = @"";
    kingsboroughPark.street = @"2311 E Holmes Ave";
    kingsboroughPark.city = @"Mesa";
    kingsboroughPark.state = @"Arizona";
    kingsboroughPark.zipCode = @"85204";
    kingsboroughPark.rating = [NSNumber numberWithInt:-1];
    kingsboroughPark.perks = @[];
    //kingsboroughPark.images = @[];
    [kingsboroughPark pinInBackground];
    [kingsboroughPark saveInBackground];
    
    ParkPFObject *kleinmanPark = [ParkPFObject new];
    kleinmanPark.name = @"Kleinman Park";
    kleinmanPark.latitude = 33.4014835;
    kleinmanPark.longitude = -111.847535;
    kleinmanPark.phoneNumber = @"(480) 644-2352";
    kleinmanPark.street = @"710 S Ext Rd";
    kleinmanPark.city = @"Mesa";
    kleinmanPark.state = @"Arizona";
    kleinmanPark.zipCode = @"85210";
    kleinmanPark.rating = [NSNumber numberWithInt:-1];
    kleinmanPark.perks = @[];
    //kleinmanPark.images = @[];
    [kleinmanPark pinInBackground];
    [kleinmanPark saveInBackground];
    
    ParkPFObject *losAlmosPark = [ParkPFObject new];
    losAlmosPark.name = @"Los Almos Park";
    losAlmosPark.latitude = 33.4014835;
    losAlmosPark.longitude = -111.76988499999999;
    losAlmosPark.phoneNumber = @"(480) 644-2352";
    losAlmosPark.street = @"2840 E Covina St";
    losAlmosPark.city = @"Mesa";
    losAlmosPark.state = @"Arizona";
    losAlmosPark.zipCode = @"85213";
    losAlmosPark.rating = [NSNumber numberWithInt:-1];
    losAlmosPark.perks = @[];
    //losAlmosPark.images = @[];
    [losAlmosPark pinInBackground];
    [losAlmosPark saveInBackground];
    
    ParkPFObject *meadowgreenPark = [ParkPFObject new];
    meadowgreenPark.name = @"Meadowgreen Park";
    meadowgreenPark.latitude = 33.4019912;
    meadowgreenPark.longitude = -111.76981890000002;
    meadowgreenPark.phoneNumber = @"(480) 644-2352";
    meadowgreenPark.street = @"2821 E Pueblo Ave";
    meadowgreenPark.city = @"Mesa";
    meadowgreenPark.state = @"Arizona";
    meadowgreenPark.zipCode = @"85204";
    meadowgreenPark.rating = [NSNumber numberWithInt:-1];
    meadowgreenPark.perks = @[];
    //meadowgreenPark.images = @[];
    [meadowgreenPark pinInBackground];
    [meadowgreenPark saveInBackground];
    
    ParkPFObject *montereyPark = [ParkPFObject new];
    montereyPark.name = @"Monterey Park";
    montereyPark.latitude = 33.4019912;
    montereyPark.longitude = -111.76981890000002;
    montereyPark.phoneNumber = @"(480) 644-2352";
    montereyPark.street = @"7045 E Monterey Ave";
    montereyPark.city = @"Mesa";
    montereyPark.state = @"Arizona";
    montereyPark.zipCode = @"85212";
    montereyPark.rating = [NSNumber numberWithInt:-1];
    montereyPark.perks = @[];
    //montereyPark.images = @[];
    [montereyPark pinInBackground];
    [montereyPark saveInBackground];
    
    ParkPFObject *mountainViewPark = [ParkPFObject new];
    mountainViewPark.name = @"Mountain View Park";
    mountainViewPark.latitude = 33.4311563;
    mountainViewPark.longitude = -111.7697053;
    mountainViewPark.phoneNumber = @"(480) 644-2011";
    mountainViewPark.street = @"845 N Lindsay Rd";
    mountainViewPark.city = @"Mesa";
    mountainViewPark.state = @"Arizona";
    mountainViewPark.zipCode = @"85213";
    mountainViewPark.rating = [NSNumber numberWithInt:-1];
    mountainViewPark.perks = @[];
    //mountainViewPark.images = @[];
    [mountainViewPark pinInBackground];
    [mountainViewPark saveInBackground];
    
    ParkPFObject *paloVerdePark = [ParkPFObject new];
    paloVerdePark.name = @"Palo Verde Park";
    paloVerdePark.latitude = 33.357841;
    paloVerdePark.longitude = -111.87449200000003;
    paloVerdePark.phoneNumber = @"(480) 644-2011";
    paloVerdePark.street = @"3135 S Dobson Rd";
    paloVerdePark.city = @"Mesa";
    paloVerdePark.state = @"Arizona";
    paloVerdePark.zipCode = @"85202";
    paloVerdePark.rating = [NSNumber numberWithInt:-1];
    paloVerdePark.perks = @[];
    //paloVerdePark.images = @[];
    [paloVerdePark pinInBackground];
    [paloVerdePark saveInBackground];
    
    ParkPFObject *parkOfTheCanalsPark = [ParkPFObject new];
    parkOfTheCanalsPark.name = @"Park Of The Canals";
    parkOfTheCanalsPark.latitude = 33.443226;
    parkOfTheCanalsPark.longitude = -111.81685099999999;
    parkOfTheCanalsPark.phoneNumber = @"(480) 644-4271";
    parkOfTheCanalsPark.street = @"1710 N Horne";
    parkOfTheCanalsPark.city = @"Mesa";
    parkOfTheCanalsPark.state = @"Arizona";
    parkOfTheCanalsPark.zipCode = @"85203";
    parkOfTheCanalsPark.rating = [NSNumber numberWithInt:-1];
    parkOfTheCanalsPark.perks = @[];
    //parkOfTheCanalsPark.images = @[];
    [parkOfTheCanalsPark pinInBackground];
    [parkOfTheCanalsPark saveInBackground];
    
    ParkPFObject *pequenoPark = [ParkPFObject new];
    pequenoPark.name = @"Pequeno Park";
    pequenoPark.latitude = 33.443226;
    pequenoPark.longitude = -111.81685099999999;
    pequenoPark.phoneNumber = @"(480) 644-2352";
    pequenoPark.street = @"537 N Oakland";
    pequenoPark.city = @"Mesa";
    pequenoPark.state = @"Arizona";
    pequenoPark.zipCode = @"85205";
    pequenoPark.rating = [NSNumber numberWithInt:-1];
    pequenoPark.perks = @[];
    //pequenoPark.images = @[];
    [pequenoPark pinInBackground];
    [pequenoPark saveInBackground];
    
    ParkPFObject *pioneerPark = [ParkPFObject new];
    pioneerPark.name = @"Pioneer Park";
    pioneerPark.latitude = 33.443226;
    pioneerPark.longitude = -111.81967400000002;
    pioneerPark.phoneNumber = @"(480) 644-4271";
    pioneerPark.street = @"526 E Main St";
    pioneerPark.city = @"Mesa";
    pioneerPark.state = @"Arizona";
    pioneerPark.zipCode = @"85203";
    pioneerPark.rating = [NSNumber numberWithInt:-1];
    pioneerPark.perks = @[];
    //pioneerPark.images = @[];
    [pioneerPark pinInBackground];
    [pioneerPark saveInBackground];
    
    ParkPFObject *porterPark = [ParkPFObject new];
    porterPark.name = @"Porter Park";
    porterPark.latitude = 33.4300207;
    porterPark.longitude = -111.82107780000001;
    porterPark.phoneNumber = @"";
    porterPark.street = @"420 E 8th St";
    porterPark.city = @"Mesa";
    porterPark.state = @"Arizona";
    porterPark.zipCode = @"85203";
    porterPark.rating = [NSNumber numberWithInt:-1];
    porterPark.perks = @[];
    //porterPark.images = @[];
    [porterPark pinInBackground];
    [porterPark saveInBackground];
    
    ParkPFObject *princessPark = [ParkPFObject new];
    princessPark.name = @"Princess Park";
    princessPark.latitude = 33.440717;
    princessPark.longitude = -111.73487;
    princessPark.phoneNumber = @"(480) 644-2352";
    princessPark.street = @"4461 E Princess Dr";
    princessPark.city = @"Mesa";
    princessPark.state = @"Arizona";
    princessPark.zipCode = @"85205";
    princessPark.rating = [NSNumber numberWithInt:-1];
    princessPark.perks = @[];
    //princessPark.images = @[];
    [princessPark pinInBackground];
    [princessPark saveInBackground];
    
    ParkPFObject *quailRunPark = [ParkPFObject new];
    quailRunPark.name = @"Quail Run Park";
    quailRunPark.latitude = 33.475536;
    quailRunPark.longitude = -111.74187899999998;
    quailRunPark.phoneNumber = @"(480) 644-3040";
    quailRunPark.street = @"4155 E Virginia St";
    quailRunPark.city = @"Mesa";
    quailRunPark.state = @"Arizona";
    quailRunPark.zipCode = @"85215";
    quailRunPark.rating = [NSNumber numberWithInt:-1];
    quailRunPark.perks = @[];
    //quailRunPark.images = @[];
    [quailRunPark pinInBackground];
    [quailRunPark saveInBackground];
    
    ParkPFObject *ranchoDelMarPark = [ParkPFObject new];
    ranchoDelMarPark.name = @"Rancho Del Mar Park";
    ranchoDelMarPark.latitude = 33.3667596;
    ranchoDelMarPark.longitude = -111.84954579999999;
    ranchoDelMarPark.phoneNumber = @"(480) 644-2011";
    ranchoDelMarPark.street = @"748 W Guadalupe Rd";
    ranchoDelMarPark.city = @"Mesa";
    ranchoDelMarPark.state = @"Arizona";
    ranchoDelMarPark.zipCode = @"85210";
    ranchoDelMarPark.rating = [NSNumber numberWithInt:-1];
    ranchoDelMarPark.perks = @[];
    //ranchoDelMarPark.images = @[];
    [ranchoDelMarPark pinInBackground];
    [ranchoDelMarPark saveInBackground];
    
    ParkPFObject *redMountainPark = [ParkPFObject new];
    redMountainPark.name = @"Red Mountain Park";
    redMountainPark.latitude = 33.4343467;
    redMountainPark.longitude = -111.6694091;
    redMountainPark.phoneNumber = @"(480) 644-4271";
    redMountainPark.street = @"7745 E Brown Rd";
    redMountainPark.city = @"Mesa";
    redMountainPark.state = @"Arizona";
    redMountainPark.zipCode = @"85207";
    redMountainPark.rating = [NSNumber numberWithInt:-1];
    redMountainPark.perks = @[];
    //redMountainPark.images = @[];
    [redMountainPark pinInBackground];
    [redMountainPark saveInBackground];
    
    ParkPFObject *reedPark = [ParkPFObject new];
    reedPark.name = @"Reed Skate Park";
    reedPark.latitude = 33.406036;
    reedPark.longitude = -111.79576099999997;
    reedPark.phoneNumber = @"(480) 644-4271";
    reedPark.street = @"1631 E Broadway Rd";
    reedPark.city = @"Mesa";
    reedPark.state = @"Arizona";
    reedPark.zipCode = @"85204";
    reedPark.rating = [NSNumber numberWithInt:-1];
    reedPark.perks = @[];
    //reedPark.images = @[];
    [reedPark pinInBackground];
    [reedPark saveInBackground];
    
    ParkPFObject *riverviewPark = [ParkPFObject new];
    riverviewPark.name = @"Riverview Park";
    riverviewPark.latitude = 33.4322497;
    riverviewPark.longitude = -111.8744021;
    riverviewPark.phoneNumber = @"(480) 644-2352";
    riverviewPark.street = @"2100 W 8th St";
    riverviewPark.city = @"Mesa";
    riverviewPark.state = @"Arizona";
    riverviewPark.zipCode = @"85201";
    riverviewPark.rating = [NSNumber numberWithInt:-1];
    riverviewPark.perks = @[];
    //riverviewPark.images = @[];
    [riverviewPark pinInBackground];
    [riverviewPark saveInBackground];
    
    ParkPFObject *sheepherdersPark = [ParkPFObject new];
    sheepherdersPark.name = @"Sheepherders Park";
    sheepherdersPark.latitude = 33.466322;
    sheepherdersPark.longitude = -111.77815099999998;
    sheepherdersPark.phoneNumber = @"(480) 644-2352";
    sheepherdersPark.street = @"2455 E McDowell Rd";
    sheepherdersPark.city = @"Mesa";
    sheepherdersPark.state = @"Arizona";
    sheepherdersPark.zipCode = @"85213";
    sheepherdersPark.rating = [NSNumber numberWithInt:-1];
    sheepherdersPark.perks = @[];
    //sheepherdersPark.images = @[];
    [sheepherdersPark pinInBackground];
    [sheepherdersPark saveInBackground];
    
    ParkPFObject *sherwoodPark = [ParkPFObject new];
    sherwoodPark.name = @"Sherwood Park";
    sherwoodPark.latitude = 33.3890862;
    sherwoodPark.longitude = -111.81420300000002;
    sherwoodPark.phoneNumber = @"(480) 644-2011";
    sherwoodPark.street = @"1453 S Horne";
    sherwoodPark.city = @"Mesa";
    sherwoodPark.state = @"Arizona";
    sherwoodPark.zipCode = @"85204";
    sherwoodPark.rating = [NSNumber numberWithInt:-1];
    sherwoodPark.perks = @[];
    //sherwoodPark.images = @[];
    [sherwoodPark pinInBackground];
    [sherwoodPark saveInBackground];
    
    ParkPFObject *silvergatePark = [ParkPFObject new];
    silvergatePark.name = @"Silvergate Park";
    silvergatePark.latitude = 33.3985386;
    silvergatePark.longitude = -111.7849976;
    silvergatePark.phoneNumber = @"(480) 644-2011";
    silvergatePark.street = @"2121 E Enid Ave";
    silvergatePark.city = @"Mesa";
    silvergatePark.state = @"Arizona";
    silvergatePark.zipCode = @"85204";
    silvergatePark.rating = [NSNumber numberWithInt:-1];
    silvergatePark.perks = @[];
    //silvergatePark.images = @[];
    [silvergatePark pinInBackground];
    [silvergatePark saveInBackground];
    
    ParkPFObject *skylinePark = [ParkPFObject new];
    skylinePark.name = @"Skyline Park";
    skylinePark.latitude = 33.4023394;
    skylinePark.longitude = -111.61239109999997;
    skylinePark.phoneNumber = @"(480) 644-4271";
    skylinePark.street = @"655 S Crismon Rd";
    skylinePark.city = @"Mesa";
    skylinePark.state = @"Arizona";
    skylinePark.zipCode = @"85208";
    skylinePark.rating = [NSNumber numberWithInt:-1];
    skylinePark.perks = @[];
    //skylinePark.images = @[];
    [skylinePark pinInBackground];
    [skylinePark saveInBackground];
    
    ParkPFObject *stapleyPark = [ParkPFObject new];
    stapleyPark.name = @"Stapley Park";
    stapleyPark.latitude = 33.4085536;
    stapleyPark.longitude = -111.82068900000002	;
    stapleyPark.phoneNumber = @"(480) 644-2352";
    stapleyPark.street = @"360 S Lesueur";
    stapleyPark.city = @"Mesa";
    stapleyPark.state = @"Arizona";
    stapleyPark.zipCode = @"85204";
    stapleyPark.rating = [NSNumber numberWithInt:-1];
    stapleyPark.perks = @[];
    //stapleyPark.images = @[];
    [stapleyPark pinInBackground];
    [stapleyPark saveInBackground];
    
    ParkPFObject *summitPark = [ParkPFObject new];
    summitPark.name = @"Summit Park";
    summitPark.latitude = 33.4772041;
    summitPark.longitude = -111.69633450000003;
    summitPark.phoneNumber = @"(480) 644-2011";
    summitPark.street = @"6237 E Virginia St";
    summitPark.city = @"Mesa";
    summitPark.state = @"Arizona";
    summitPark.zipCode = @"85215";
    summitPark.rating = [NSNumber numberWithInt:-1];
    summitPark.perks = @[];
    //summitPark.images = @[];
    [summitPark pinInBackground];
    [summitPark saveInBackground];
    
    ParkPFObject *valenciaPark = [ParkPFObject new];
    valenciaPark.name = @"Valencia Park";
    valenciaPark.latitude = 33.4271453;
    valenciaPark.longitude = -111.73213169999997;
    valenciaPark.phoneNumber = @"(480) 644-2011";
    valenciaPark.street = @"634 N Quail";
    valenciaPark.city = @"Mesa";
    valenciaPark.state = @"Arizona";
    valenciaPark.zipCode = @"85205";
    valenciaPark.rating = [NSNumber numberWithInt:-1];
    valenciaPark.perks = @[];
    //valenciaPark.images = @[];
    [valenciaPark pinInBackground];
    [valenciaPark saveInBackground];
    
    ParkPFObject *vistaMontereyPark = [ParkPFObject new];
    vistaMontereyPark.name = @"Vista Monterey Park";
    vistaMontereyPark.latitude = 33.427561;
    vistaMontereyPark.longitude = -111.75305600000002;
    vistaMontereyPark.phoneNumber = @"(480) 644-2011";
    vistaMontereyPark.street = @"633 N Val Vista Dr";
    vistaMontereyPark.city = @"Mesa";
    vistaMontereyPark.state = @"Arizona";
    vistaMontereyPark.zipCode = @"85205";
    vistaMontereyPark.rating = [NSNumber numberWithInt:-1];
    vistaMontereyPark.perks = @[];
    //vistaMontereyPark.images = @[];
    [vistaMontereyPark pinInBackground];
    [vistaMontereyPark saveInBackground];
    
    ParkPFObject *washingtonPark = [ParkPFObject new];
    washingtonPark.name = @"Washington Park";
    washingtonPark.latitude = 33.4241416;
    washingtonPark.longitude = -111.8302089;
    washingtonPark.phoneNumber = @"";
    washingtonPark.street = @"44 E 5th St";
    washingtonPark.city = @"Mesa";
    washingtonPark.state = @"Arizona";
    washingtonPark.zipCode = @"85201";
    washingtonPark.rating = [NSNumber numberWithInt:-1];
    washingtonPark.perks = @[];
    //washingtonPark.images = @[];
    [washingtonPark pinInBackground];
    [washingtonPark saveInBackground];
    
    ParkPFObject *whitmanPark = [ParkPFObject new];
    whitmanPark.name = @"Whitman Park";
    whitmanPark.latitude = 33.4470718;
    whitmanPark.longitude = -111.83549590000001;
    whitmanPark.phoneNumber = @"(480) 644-2011";
    whitmanPark.street = @"1700 N Grand";
    whitmanPark.city = @"Mesa";
    whitmanPark.state = @"Arizona";
    whitmanPark.zipCode = @"85201";
    whitmanPark.rating = [NSNumber numberWithInt:-1];
    whitmanPark.perks = @[];
    //whitmanPark.images = @[];
    [whitmanPark pinInBackground];
    [whitmanPark saveInBackground];
    
    ParkPFObject *woodglenPark = [ParkPFObject new];
    woodglenPark.name = @"Woodglen Park";
    woodglenPark.latitude = 33.372351;
    woodglenPark.longitude = -111.85519399999998;
    woodglenPark.phoneNumber = @"(480) 644-2352";
    woodglenPark.street = @"2342 S Beverly";
    woodglenPark.city = @"Mesa";
    woodglenPark.state = @"Arizona";
    woodglenPark.zipCode = @"85210";
    woodglenPark.rating = [NSNumber numberWithInt:-1];
    woodglenPark.perks = @[];
    //woodglenPark.images = @[];
    [woodglenPark pinInBackground];
    [woodglenPark saveInBackground];
}

@end
