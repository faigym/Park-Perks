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
              kTireSwing,
              kTubeSlide,
              kOpenSlide,
              kToddlerPlayEquipment,
              kClimbingNet,
              kWoodChips,
              kRubber,
              kSand,
              kMonkeyBars,
              kPreschoolActivities,
              kSplashPad,
              kBucketSpinner,
              kHoopSpinner,
              kClimbingWall,
              kBalanceBeam,
              kExerciseStations,
              kElectronicGameStations,
              kZipLine,
              kMerryGoRound,
              kPlaySystem,
              kSandDigger,
              kSpringRocker,
              kShaded],
      kCategoryExercise:@[
              kWalkingJoggingPath,
              kChinUp,
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
              kLapSwim,
              kDrinkingFountain,
              kDivingBoard,
              kHighDive,
              kWaterNozzle,
              kPond,
              kCreek],
      kCategorySports:@[
              kBaseball,
              kSoccer,
              kFootball,
              kBasketBall,
              kTennis,
              kRaquetBall,
              kVolleyBall,
              kBMX,
              kSkate,
              kDiscGolf,
              kBicycling,
              kHorseShoes,
              kPickleball,
              kRugby,
              kOutdoorIceRink],
      kCategoryHistory:@[
              kMemorials,
              kPlaques,
              kAntiAircraftGuns],
      kCategoryFacilities:@[
              kBathroom,
              kWaterFountain,
              kElectricity,
              kLighting,
              kDogsAllowed,
              kDogsOffLeashAllowed,
              kDrones,
              kKites,
              kSurface,
              kShade,
              kBBQGas,
              kBBQFirePit,
              kBBQCharcoal,
              kShelter,
              kPavilion,
              kRamada,
              kAlcoholPermit,
              kSeating,
              kHorsetrails,
              kOutdoorFireplace],
      kCategoryPicnic:@[
              kBBQGas,
              kBBQFirePit,
              kBBQCharcoal,
              kShelter,
              kPavilion,
              kRamada,
              kAlcoholPermit,
              kSeating]
      };
    
    [categoryLUT pinInBackground];
    [categoryLUT saveInBackground];
}

-(void)remakeParkTestDatabase
{
    ParkPFObject *murrayPark = [ParkPFObject new];
    murrayPark.foursquareObjectId = @"4bc0fe774cdfc9b671ee9321";
    murrayPark.name = @"Murray Park";
    murrayPark.latitude = 40.65928505282439;
    murrayPark.longitude = -111.8822121620178;
    murrayPark.phoneNumber = @"801-264-2614";
    murrayPark.rating = [NSNumber numberWithInt:5];
    murrayPark.perks = @[kPond, kDucks, kChinUp, kToddlerPlayEquipment, kSand, kTubeSlide, kOpenSlide, kOutdoorPool, kOutdoorIceRink, kWaterSlide, kRugby, kSoccer, kLargeTrees, kHills, kVolleyBall, kExerciseStations, kCreek, kLighting, kPavilion, kWaterFountain, kOutdoorPool, kPlaySystem, kSwings, kBabySwing, kTireSwing];
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
    
    ParkPFObject *friendshipPark = [ParkPFObject new];
    friendshipPark.foursquareObjectId = @"4bf6ab6f5efe2d7f428d6734";
    friendshipPark.name = @"Friendship Park";
    friendshipPark.latitude = 40.645818;
    friendshipPark.longitude = -111.879023;
    friendshipPark.phoneNumber = @"Not available";
    friendshipPark.rating = [NSNumber numberWithInt:3];
    friendshipPark.perks = @[kSand, kMerryGoRound, kToddlerPlayEquipment, kVolleyBall, kSwings, kPavilion, kBaseball, kWalkingJoggingPath, kOpenSlide, kPlaySystem, kBabySwing];
    //friendshipPark.images = @[];
    [friendshipPark pinInBackground];
    [friendshipPark saveInBackground];
    
    ParkPFObject *rivertonPark = [ParkPFObject new];
    rivertonPark.foursquareObjectId = @"4bd3616a41b9ef3bdb0b00e6";
    rivertonPark.name = @"Riverton City Park";
    rivertonPark.latitude = 40.5181;
    rivertonPark.longitude = -111.9322;
    rivertonPark.phoneNumber = @"(801) 254-0704";
    rivertonPark.rating = [NSNumber numberWithInt:4];
    rivertonPark.perks = @[kHorseShoes, kSkate, kBMX, kPickleball, kPavilion, kPlaySystem, kMemorials, kSwings];
    //rivertonPark.images = @[];
    [rivertonPark pinInBackground];
    [rivertonPark saveInBackground];
}

@end
