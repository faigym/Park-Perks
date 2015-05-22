//
//  Constants.m
//  Park Perks
//
//  Created by Douglas Voss on 5/20/15.
//  Copyright (c) 2015 Skyler Clark. All rights reserved.
//

#import "Constants.h"
#import "PerkPropLUTPFObject.h"

@interface Constants()

@property (nonatomic, strong, readwrite) PerkPropLUTPFObject *perkPropLUT;
@property (nonatomic, strong, readwrite) NSDictionary *perkDict;
@property (nonatomic, strong, readwrite) NSDictionary *categoryDict;

@end

@implementation Constants

+ (instancetype) sharedInstance
{
    static Constants *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[Constants alloc] init];
        
        sharedInstance.perkPropLUT = [PerkPropLUTPFObject new];
        PFQuery *query = [PerkPropLUTPFObject query];
        NSUInteger limit = 1;
        NSUInteger skip = 0;
        [query setLimit: limit];
        [query setSkip: skip];
        [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
            sharedInstance.perkPropLUT = objects[0];
            sharedInstance.perkDict = sharedInstance.perkPropLUT.perkDict;
            sharedInstance.categoryDict = [Constants categoryDictFromPerkDict:sharedInstance.perkDict];
            //NSLog(@"perkPropLUT loaded in Singleton Constants");
            //NSLog(@"Categories:%@", sharedInstance.perkPropLUT.categoryDict);
            [[NSNotificationCenter defaultCenter] postNotificationName:kPerkPropLUTLoaded object:nil];
        }];
    });

    return sharedInstance;
}

+ (NSDictionary *)categoryDictFromPerkDict:(NSDictionary *)perkDict
{
    NSMutableDictionary *mutDict = [NSMutableDictionary new];
    
    for (NSString *perk in [perkDict allKeys])
    {
        NSArray *categoryArr = [perkDict valueForKey:perk];
        NSMutableArray *perksPerCategory;
        for (NSString *categoryStr in categoryArr)
        {
            perksPerCategory = [mutDict objectForKey:categoryStr];
            if (!perksPerCategory) {
                NSMutableArray *perksPerCategory = [NSMutableArray new];
                [mutDict setValue:perksPerCategory forKey:categoryStr];
            }
            [perksPerCategory addObject:perk];
        }
    }
    //NSLog(@"mutDict==%@", mutDict);
    return mutDict;
}

- (NSArray *)perksForCategory:(NSString *)category
{
    return [self.categoryDict valueForKey:category];
}

/*- (NSArray *)categoriesForPerk:(NSString *perk)
{
    if (self.perkPropLUT) {
        
    }
}*/

- (NSArray *)allCategories
{
    return [self.categoryDict allKeys];
}

- (NSArray *)allPerks
{
    return [self.perkDict allKeys];
/*return @[
kCategoryPlayground,
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
kShaded,
kCategoryExercise,
kWalkingJoggingPath,
kChinUp,
kCategoryNature,
kCreek,
kPond,
kArboretum,
kDucks,
kFishing,
kAviary,
kCategoryWater,
kOutdoorPool,
kWaterSlide,
kBabyPool,
kLapSwim,
kDrinkingFountain,
kDivingBoard,
kHighDive,
kWaterNozzle,
kCategorySports,
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
kCategoryHistory,
kMemorials,
kCategoryFacilities,
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
kCategoryPicnic,
kBBQGas,
kBBQFirePit,
kBBQCharcoal,
kShelter,
kPavilion,
kRamada,
kAlcoholPermit,
kSeating];*/
}

- (NSArray *)playgroundStringLUT
{
return @[
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
kShaded];
}

- (NSArray *)exerciseStringLUT
{
return @[
kWalkingJoggingPath,
kChinUp,
kExerciseStations];
}

- (NSArray *)natureStringLUT
{
return @[
kCreek,
kPond,
kArboretum,
kDucks,
kFishing,
kAviary];
}

- (NSArray *)waterStringLUT
{
return @[
kOutdoorPool,
kWaterSlide,
kBabyPool,
kLapSwim,
kCreek,
kPond,
kSplashPad,
kDrinkingFountain,
kDivingBoard,
kHighDive,
kWaterNozzle];
}

- (NSArray *)sportsStringLUT
{
return @[
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
kHorseShoes];
}

- (NSArray *)historyStringLUT
{
return @[
kMemorials];
}

- (NSArray *)facilitiesStringLUT
{
return @[
kBathroom,
kWaterFountain,
kElectricity,
kLighting,
kDogsAllowed,
kDogsOffLeashAllowed,
kDrones,
kKites,
kSurface,
kShade];
}

- (NSArray *)picnicStringLUT
{
return @[
kBBQGas,
kBBQFirePit,
kBBQCharcoal,
kShelter,
kPavilion,
kRamada,
kAlcoholPermit,
kSeating];
}

- (NSString *)categoryTitleForSection:(NSInteger)section
{
    switch (section) {
        case CategoryTypePlayground: return kCategoryPlayground;    break;
        case CategoryTypeExercise:   return kCategoryExercise;      break;
        case CategoryTypeNature:     return kCategoryNature;        break;
        case CategoryTypeWater:      return kCategoryWater;         break;
        case CategoryTypeSports:     return kCategorySports;        break;
        case CategoryTypeHistory:    return kCategoryHistory;       break;
        case CategoryTypeFacilities: return kCategoryFacilities;    break;
        case CategoryTypePicnic:     return kCategoryPicnic;        break;
        default:                     return kCategoryOther;         break;
    }
}

@end
