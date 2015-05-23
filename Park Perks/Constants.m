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
    murrayPark.name = @"Murray Park";
    murrayPark.latitude = 40.65928505282439;
    murrayPark.longitude = -111.8822121620178;
    murrayPark.phoneNumber = @"801-264-2614";
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
    NSData *imageData = UIImageJPEGRepresentation([UIImage imageNamed:@"MurrayParkEastPlaysystem.jpg"], 0.5);
    PFFile *imagePFFile = [PFFile fileWithName:@"MurrayParkEastPlaysystem.jpg" data:imageData];
    imagePFObj[@"ImageFile"] = imagePFFile;
    [imagePFObj setObject:murrayPark forKey:@"pointerToPark"];
    [imagePFObj pinInBackground];
    [imagePFObj saveInBackground];
    
    PFObject *imagePFObj2 = [PFObject objectWithClassName:@"ParkImage"];
    NSData *imageData2 = UIImageJPEGRepresentation([UIImage imageNamed:@"MurrayParkWestPlaysystem.jpg"], 0.5);
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
    friendshipPark.rating = [NSNumber numberWithInt:3];
    friendshipPark.perks = @[kSand, kMerryGoRound, kToddlerPlayEquipment, kVolleyBallSand, kSwings, kPavilion, kBaseball, kWalkingJoggingPath,kPlaySystem, kBabySwing];
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
    rivertonPark.perks = @[kHorseShoes, kSkatePark, kPickleball, kPavilion, kPlaySystem, kSwings];
    //rivertonPark.images = @[];
    [rivertonPark pinInBackground];
    [rivertonPark saveInBackground];
}

@end
