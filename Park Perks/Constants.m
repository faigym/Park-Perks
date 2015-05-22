//
//  Constants.m
//  Park Perks
//
//  Created by Douglas Voss on 5/20/15.
//  Copyright (c) 2015 Skyler Clark. All rights reserved.
//

#import "Constants.h"
#import "PerkPropLUTPFObject.h"
#import "ParkPFObject.h"

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
            if (objects==nil) {
                NSLog(@"Load of perk dictionary from parse database failed.");
            }
            sharedInstance.perkPropLUT = objects[0];
            sharedInstance.perkDict = sharedInstance.perkPropLUT.perkDict;
            sharedInstance.categoryDict = [sharedInstance categoryDictFromPerkDict:sharedInstance.perkDict];
            //NSLog(@"perkPropLUT loaded in Singleton Constants");
            //NSLog(@"Categories:%@", sharedInstance.perkPropLUT.categoryDict);
            [[NSNotificationCenter defaultCenter] postNotificationName:kPerkPropLUTLoaded object:nil];
        }];
    });

    return sharedInstance;
}

- (NSDictionary *)categoryDictFromPerkDict:(NSDictionary *)perkDict
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
                perksPerCategory = [NSMutableArray new];
                [mutDict setValue:perksPerCategory forKey:categoryStr];
            }
            [perksPerCategory addObject:perk];
        }
    }
    //NSLog(@"mutDict==%@", mutDict);
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
    return [[self.categoryDict valueForKey:category] count];
}

- (NSInteger)numberOfPerksForTableviewSection:(NSInteger )section
{
    return [self numberOfPerksForCategory:[self categoryForTableviewSection:section]];
}

- (NSArray *)perksForCategory:(NSString *)category
{
    return [self.categoryDict valueForKey:category];
}

- (NSArray *)perksForTableviewSection:(NSInteger)section
{
    return [self.categoryDict objectForKey:[self categoryForTableviewSection:section]];
}

- (NSArray *)allCategories
{
    return [self.categoryDict allKeys];
}

- (NSArray *)allPerks
{
    return [self.perkDict allKeys];
}

-(void)remakePerkLUT
{
    PerkPropLUTPFObject *perkProp = [PerkPropLUTPFObject new];
    /*perkProp.perkDict = @{kWalkingJoggingPath:@[kCategoryExercise],
                          kChinUp:@[kCategoryExercise],
                          kMemorials:@[kCategoryHistory]};*/
    perkProp.perkDict = @{
      kSeeSaw:@[kCategoryPlayground],
      kBabySwing:@[kCategoryPlayground],
      kSwings:@[kCategoryPlayground],
      kTireSwing:@[kCategoryPlayground],
      kTubeSlide:@[kCategoryPlayground],
      kOpenSlide:@[kCategoryPlayground],
      kToddlerPlayEquipment:@[kCategoryPlayground],
      kClimbingNet:@[kCategoryPlayground],
      kWoodChips:@[kCategoryPlayground],
      kRubber:@[kCategoryPlayground],
      kSand:@[kCategoryPlayground],
      kMonkeyBars:@[kCategoryPlayground],
      kPreschoolActivities:@[kCategoryPlayground],
      kSplashPad:@[kCategoryPlayground],
      kBucketSpinner:@[kCategoryPlayground],
      kHoopSpinner:@[kCategoryPlayground],
      kClimbingWall:@[kCategoryPlayground],
      kBalanceBeam:@[kCategoryPlayground],
      kExerciseStations:@[kCategoryPlayground, kCategoryExercise],
      kElectronicGameStations:@[kCategoryPlayground],
      kZipLine:@[kCategoryPlayground],
      kMerryGoRound:@[kCategoryPlayground],
      kPlaySystem:@[kCategoryPlayground],
      kSandDigger:@[kCategoryPlayground],
      kSpringRocker:@[kCategoryPlayground],
      kShaded:@[kCategoryPlayground],
      kWalkingJoggingPath:@[kCategoryExercise, kCategoryFacilities],
      kChinUp:@[kCategoryExercise],
      kCreek:@[kCategoryNature, kCategoryWater],
      kPond:@[kCategoryNature, kCategoryWater],
      kArboretum:@[kCategoryNature],
      kDucks:@[kCategoryNature],
      kFishing:@[kCategoryNature, kCategorySports],
      kAviary:@[kCategoryNature],
      kLargeTrees:@[kCategoryNature],
      kOutdoorPool:@[kCategoryWater],
      kWaterSlide:@[kCategoryWater],
      kBabyPool:@[kCategoryWater],
      kLapSwim:@[kCategoryWater],
      kDrinkingFountain:@[kCategoryWater],
      kDivingBoard:@[kCategoryWater],
      kHighDive:@[kCategoryWater],
      kWaterNozzle:@[kCategoryWater],
      kBaseball:@[kCategorySports],
      kSoccer:@[kCategorySports],
      kFootball:@[kCategorySports],
      kBasketBall:@[kCategorySports],
      kTennis:@[kCategorySports],
      kRaquetBall:@[kCategorySports],
      kVolleyBall:@[kCategorySports],
      kBMX:@[kCategorySports],
      kSkate:@[kCategorySports],
      kDiscGolf:@[kCategorySports],
      kBicycling:@[kCategorySports],
      kHorseShoes:@[kCategorySports],
      kPickleball:@[kCategorySports],
      kMemorials:@[kCategoryHistory],      
      kBathroom:@[kCategoryFacilities],
      kWaterFountain:@[kCategoryFacilities],
      kElectricity:@[kCategoryFacilities],
      kLighting:@[kCategoryFacilities],
      kDogsAllowed:@[kCategoryFacilities],
      kDogsOffLeashAllowed:@[kCategoryFacilities],
      kDrones:@[kCategoryFacilities],
      kKites:@[kCategoryFacilities],
      kSurface:@[kCategoryFacilities],
      kShade:@[kCategoryFacilities],
      kBBQGas:@[kCategoryPicnic],
      kBBQFirePit:@[kCategoryPicnic],
      kBBQCharcoal:@[kCategoryPicnic],
      kShelter:@[kCategoryPicnic],
      kPavilion:@[kCategoryPicnic],
      kRamada:@[kCategoryPicnic],
      kAlcoholPermit:@[kCategoryPicnic],
      kSeating:@[kCategoryFacilities, kCategoryPicnic],
      kHorsetrails:@[kCategoryFacilities]
    };
    
    [perkProp pinInBackground];
    [perkProp saveInBackground];
}

-(void)remakeParkTestDatabase
{
    ParkPFObject *murrayPark = [ParkPFObject new];
    murrayPark.foursquareObjectId = @"4bc0fe774cdfc9b671ee9321";
    murrayPark.name = @"Murray Park";
    murrayPark.latitude = 40.65928505282439;
    murrayPark.longitude = -111.8822121620178;
    murrayPark.rating = [NSNumber numberWithInt:5];
    murrayPark.perks = @[kPond, kDucks, kChinUp, kToddlerPlayEquipment, kSand, kTubeSlide];
    murrayPark.images = nil;
    [murrayPark pinInBackground];
    [murrayPark saveInBackground];
    
    ParkPFObject *friendshipPark = [ParkPFObject new];
    friendshipPark.foursquareObjectId = @"4bf6ab6f5efe2d7f428d6734";
    friendshipPark.name = @"Friendship Park";
    friendshipPark.latitude = 40.645818;
    friendshipPark.longitude = -111.879023;
    friendshipPark.rating = [NSNumber numberWithInt:4];
    friendshipPark.perks = @[kSand, kMerryGoRound, kToddlerPlayEquipment, kVolleyBall];
    friendshipPark.images = nil;
    [friendshipPark pinInBackground];
    [friendshipPark saveInBackground];
}

@end
