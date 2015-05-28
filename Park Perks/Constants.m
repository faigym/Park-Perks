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
              kSeeSaw,
              kBabySwing,
              kSwings,
              kToddlerPlayEquipment,
              kClimbingNet,
              kWoodChips,
              kRubberMat,
              kSand,
              kMonkeyBars,
              kPreschoolActivities,
              kSplashPad,
              kClimbingWall,
              kExerciseStations,
              kElectronicGameStations,
              kZipLine,
              kMerryGoRound,
              kPlaySystem,
              kSandDigger,
              kSpringRocker,
              kShade],
      kCategoryExercise:@[
              kWalkingJoggingPath,
              kMonkeyBars,
              kExerciseStations],
      kCategoryNature:@[
              kCreek,
              kPond,
              kArboretum,
              kDucks,
              kFishing,
              kAviary,
              kLargeTrees,
              kHills],
      kCategoryWater:@[
              kOutdoorPool,
              kWaterSlide,
              kBabyPool,
              kHighDive,
              kWaterNozzle,
              kPond,
              kCreek],
      kCategorySports:@[
              kBaseball,
              kSoccerField,
              kSoccerGoals,
              kBasketBall,
              kTennis,
              kRaquetBall,
              kVolleyBallSand,
              kSkatePark,
              kDiscGolf,
              kBicycling,
              kHorseShoes,
              kPickleball,
              kIceRink],
      kCategoryFacilities:@[
              kBathrooms,
              kWaterFountain,
              kElectricity,
              kLighting,
              kDogsAllowed,
              kDogsOffLeashAllowed,
              kShade,
              kBBQGas,
              kBBQFirePit,
              kBBQCharcoal,
              kShelter,
              kPavilion,
              kRamada,
              kAlcoholPermit,
              kSeating,
              kHorsetrails],
      kCategoryPicnic:@[
              kBBQGas,
              kBBQFirePit,
              kBBQCharcoal,
              kShelter,
              kPavilion,
              kRamada,
              kAlcoholPermit,
              kSeating,
              kPicnicTables]
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
    murrayPark.perks = @[kPond, kDucks, kMonkeyBars, kToddlerPlayEquipment, kSand, kOutdoorPool, kIceRink, kWaterSlide, kSoccerField, kLargeTrees, kHills, kVolleyBallSand, kExerciseStations, kCreek, kLighting, kPavilion, kWaterFountain, kPlaySystem, kSwings, kBabySwing];
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
    friendshipPark.perks = @[kSand, kMerryGoRound, kToddlerPlayEquipment, kVolleyBallSand, kSwings, kPavilion, kBaseball, kWalkingJoggingPath,kPlaySystem, kBabySwing];
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
    southCottonwoodPark.perks = @[kPavilion, kBathrooms, kPicnicTables, kPlaySystem, kLargeTrees];
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
    chaparrelPark.perks = @[kSoccerField];
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
    
    
}

@end
