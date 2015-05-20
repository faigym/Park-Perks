//
//  ParkModel.m
//  Park Perks
//
//  Created by Douglas Voss on 5/19/15.
//  Copyright (c) 2015 Skyler Clark. All rights reserved.
//

#import "ParkModel.h"
#ifdef STRINGPERKS
#import "Perk.h"
#else
#import "PerkProperties.h"
#endif

@implementation ParkModel : NSObject

// dynamic means I provide getter and setter methods?

/*@dynamic name;
@dynamic address;
@dynamic latitude;
@dynamic longitude;
@dynamic phoneNumber;
@dynamic perks;*/

/*- (NSString * __nonnull)parseClassName
{
    return @"ParkModelClass";
}*/

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.name = @"Empty Name";
        self.address = @"123 Nowhere Street";
        self.latitude = 0.0;
        self.longitude = 0.0;
        self.phoneNumber = @"111-1111";
	#ifdef STRINGPERKS
            self.perks = [[NSMutableArray alloc] init];
	#else
	    self.perkProps = [[PerkProperties alloc] init];
	#endif
    }
    return self;
}

- (BOOL)saveToDataBase
{
    PFObject *pfObj = [PFObject objectWithClassName:@"ParkModel"];
    pfObj[@"name"]=self.name;
    //[pfObj addObject:self.name forKey:@"name"];
    pfObj[@"address"]=self.address;
    pfObj[@"latitude"]=[NSNumber numberWithDouble:self.latitude];
    pfObj[@"longitude"]=[NSNumber numberWithDouble:self.longitude];
    pfObj[@"phoneNumber"]=self.phoneNumber;

    #ifdef STRINGPERKS
    	NSMutableArray *perkNames = [NSMutableArray new];
    	for (Perk *perk in self.perks) {
    	    [perkNames addObject:perk.name];
    	}
    	//pfObj[@"perkArray"]=perkNames;
    	NSArray *array = [[NSArray alloc] initWithArray:pfObj[@"perkArray"]];
    	array = [array arrayByAddingObject:@"testString"];
    	pfObj[@"perkArray"] = array;
    	NSLog(@"%@", pfObj[@"perkArray"]);
    #else
    pfObj[kSeeSaw]=[NSNumber numberWithBool:self.perkProps.SeeSaw];
    pfObj[kBabySwing]=[NSNumber numberWithBool:self.perkProps.BabySwing];
    pfObj[kSwings]=[NSNumber numberWithBool:self.perkProps.Swings];
    pfObj[kTireSwing]=[NSNumber numberWithBool:self.perkProps.TireSwing];
    pfObj[kTubeSlide]=[NSNumber numberWithBool:self.perkProps.TubeSlide];
    pfObj[kOpenSlide]=[NSNumber numberWithBool:self.perkProps.OpenSlide];
    pfObj[kToddlerPlayEquipment]=[NSNumber numberWithBool:self.perkProps.ToddlerPlayEquipment];
    pfObj[kClimbingNet]=[NSNumber numberWithBool:self.perkProps.ClimbingNet];
    pfObj[kWoodChips]=[NSNumber numberWithBool:self.perkProps.WoodChips];
    pfObj[kRubber]=[NSNumber numberWithBool:self.perkProps.Rubber];
    pfObj[kSand]=[NSNumber numberWithBool:self.perkProps.Sand];
    pfObj[kMonkeyBars]=[NSNumber numberWithBool:self.perkProps.MonkeyBars];
    pfObj[kPreschoolActivities]=[NSNumber numberWithBool:self.perkProps.PreschoolActivities];
    pfObj[kSplashPad]=[NSNumber numberWithBool:self.perkProps.SplashPad];
    pfObj[kBucketSpinner]=[NSNumber numberWithBool:self.perkProps.BucketSpinner];
    pfObj[kHoopSpinner]=[NSNumber numberWithBool:self.perkProps.HoopSpinner];
    pfObj[kClimbingWall]=[NSNumber numberWithBool:self.perkProps.ClimbingWall];
    pfObj[kBalanceBeam]=[NSNumber numberWithBool:self.perkProps.BalanceBeam];
    pfObj[kNovelExerciseStations]=[NSNumber numberWithBool:self.perkProps.NovelExerciseStations];
    pfObj[kElectronicGameStations]=[NSNumber numberWithBool:self.perkProps.ElectronicGameStations];
    pfObj[kZipLine]=[NSNumber numberWithBool:self.perkProps.ZipLine];
    pfObj[kMerryGoRound]=[NSNumber numberWithBool:self.perkProps.MerryGoRound];
    pfObj[kPlaySystem]=[NSNumber numberWithBool:self.perkProps.PlaySystem];
    pfObj[kSandDigger]=[NSNumber numberWithBool:self.perkProps.SandDigger];
    pfObj[kSpringRocker]=[NSNumber numberWithBool:self.perkProps.SpringRocker];
    pfObj[kShaded]=[NSNumber numberWithBool:self.perkProps.Shaded];

    pfObj[kWalkingJoggingPath]=[NSNumber numberWithBool:self.perkProps.WalkingJoggingPath];
    pfObj[kChinUp]=[NSNumber numberWithBool:self.perkProps.ChinUp];
    pfObj[kExerciseStations]=[NSNumber numberWithBool:self.perkProps.ExerciseStations];

    pfObj[kCreek]=[NSNumber numberWithBool:self.perkProps.Creek];
    pfObj[kPond]=[NSNumber numberWithBool:self.perkProps.Pond];
    pfObj[kArboretum]=[NSNumber numberWithBool:self.perkProps.Arboretum];
    pfObj[kDucks]=[NSNumber numberWithBool:self.perkProps.Ducks];
    pfObj[kFishing]=[NSNumber numberWithBool:self.perkProps.Fishing];
    pfObj[kAviary]=[NSNumber numberWithBool:self.perkProps.Aviary];

    pfObj[kOutdoorPool]=[NSNumber numberWithBool:self.perkProps.OutdoorPool];
    pfObj[kWaterSlide]=[NSNumber numberWithBool:self.perkProps.WaterSlide];
    pfObj[kBabyPool]=[NSNumber numberWithBool:self.perkProps.BabyPool];
    pfObj[kLapSwim]=[NSNumber numberWithBool:self.perkProps.LapSwim];

    pfObj[kDrinkingFountain]=[NSNumber numberWithBool:self.perkProps.DrinkingFountain];
    pfObj[kDivingBoard]=[NSNumber numberWithBool:self.perkProps.DivingBoard];
    pfObj[kHighDive]=[NSNumber numberWithBool:self.perkProps.HighDive];
    pfObj[kWaterNozzle]=[NSNumber numberWithBool:self.perkProps.WaterNozzle];

    pfObj[kBaseball]=[NSNumber numberWithBool:self.perkProps.Baseball];
    pfObj[kSoccer]=[NSNumber numberWithBool:self.perkProps.Soccer];
    pfObj[kFootball]=[NSNumber numberWithBool:self.perkProps.Football];
    pfObj[kBasketBall]=[NSNumber numberWithBool:self.perkProps.BasketBall];
    pfObj[kTennis]=[NSNumber numberWithBool:self.perkProps.Tennis];
    pfObj[kRaquetBall]=[NSNumber numberWithBool:self.perkProps.RaquetBall];
    pfObj[kVolleyBall]=[NSNumber numberWithBool:self.perkProps.VolleyBall];
    pfObj[kBMX]=[NSNumber numberWithBool:self.perkProps.BMX];
    pfObj[kSkate]=[NSNumber numberWithBool:self.perkProps.Skate];
    pfObj[kDiscGolf]=[NSNumber numberWithBool:self.perkProps.DiscGolf];
    pfObj[kBicycling]=[NSNumber numberWithBool:self.perkProps.Bicycling];
    pfObj[kHorshoes]=[NSNumber numberWithBool:self.perkProps.Horshoes];

    pfObj[kMemorials]=[NSNumber numberWithBool:self.perkProps.Memorials];

    pfObj[kBathroom]=[NSNumber numberWithBool:self.perkProps.Bathroom];
    pfObj[kWaterFountain]=[NSNumber numberWithBool:self.perkProps.WaterFountain];
    pfObj[kElectricity]=[NSNumber numberWithBool:self.perkProps.Electricity];
    pfObj[kLighting]=[NSNumber numberWithBool:self.perkProps.Lighting];
    pfObj[kDogsAllowed]=[NSNumber numberWithBool:self.perkProps.DogsAllowed];
    pfObj[kDogsOffLeashAllowed]=[NSNumber numberWithBool:self.perkProps.DogsOffLeashAllowed];
    pfObj[kDrones]=[NSNumber numberWithBool:self.perkProps.Drones];
    pfObj[kKites]=[NSNumber numberWithBool:self.perkProps.Kites];
    pfObj[kSurface]=[NSNumber numberWithBool:self.perkProps.Surface];
    pfObj[kShade]=[NSNumber numberWithBool:self.perkProps.Shade];

    pfObj[kBBQGas]=[NSNumber numberWithBool:self.perkProps.BBQGas];
    pfObj[kBBQFirePit]=[NSNumber numberWithBool:self.perkProps.BBQFirePit];
    pfObj[kBBQCharcoal]=[NSNumber numberWithBool:self.perkProps.BBQCharcoal];
    pfObj[kShelter]=[NSNumber numberWithBool:self.perkProps.Shelter];
    pfObj[kPavilion]=[NSNumber numberWithBool:self.perkProps.Pavilion];
    pfObj[kRamada]=[NSNumber numberWithBool:self.perkProps.Ramada];
    pfObj[kAlcoholPermit]=[NSNumber numberWithBool:self.perkProps.AlcoholPermit];
    pfObj[kSeating]=[NSNumber numberWithBool:self.perkProps.Seating];
    #endif                                                    
    
    [pfObj saveInBackground];
    
    return @YES;
}

- (NSString *)description
{
    NSMutableString *mutStr = [[NSMutableString alloc] init];
    [mutStr appendString:[NSString stringWithFormat:@"Name: %@\n", self.name]];
    [mutStr appendString:[NSString stringWithFormat:@"Address: %@\n", self.address]];
    [mutStr appendString:[NSString stringWithFormat:@"Latitude: %f\n", self.latitude]];
    [mutStr appendString:[NSString stringWithFormat:@"Longitude: %f\n", self.longitude]];
    [mutStr appendString:[NSString stringWithFormat:@"Phone Number: %@\n", self.phoneNumber]];
    /*[mutStr appendString:[NSString stringWithFormat:@"Perks:\n"]];
    for (Perk *perk in self.perks)
    {
        [mutStr appendString:[perk toString]];
        [mutStr appendString:@"\n"];
    }*/
    
    [mutStr appendString:[NSString stringWithFormat:@": %d\n", self.perkProps.SeeSaw]];
    [mutStr appendString:[NSString stringWithFormat:@": %d\n", self.perkProps.BabySwing]];
    [mutStr appendString:[NSString stringWithFormat:@": %d\n", self.perkProps.Swings]];
    [mutStr appendString:[NSString stringWithFormat:@": %d\n", self.perkProps.TireSwing]];
    [mutStr appendString:[NSString stringWithFormat:@": %d\n", self.perkProps.TubeSlide]];
    
    [mutStr appendString:[NSString stringWithFormat:@": %d\n", self.perkProps.TubeSlide]];
    [mutStr appendString:[NSString stringWithFormat:@": %d\n", self.perkProps.OpenSlide]];
    [mutStr appendString:[NSString stringWithFormat:@": %d\n", self.perkProps.ToddlerPlayEquipment]];
    [mutStr appendString:[NSString stringWithFormat:@": %d\n", self.perkProps.ClimbingNet]];
    [mutStr appendString:[NSString stringWithFormat:@": %d\n", self.perkProps.WoodChips]];
    [mutStr appendString:[NSString stringWithFormat:@": %d\n", self.perkProps.Rubber]];
    [mutStr appendString:[NSString stringWithFormat:@": %d\n", self.perkProps.Sand]];
    [mutStr appendString:[NSString stringWithFormat:@": %d\n", self.perkProps.MonkeyBars]];
    [mutStr appendString:[NSString stringWithFormat:@": %d\n", self.perkProps.PreschoolActivities]];
    [mutStr appendString:[NSString stringWithFormat:@": %d\n", self.perkProps.SplashPad]];
    [mutStr appendString:[NSString stringWithFormat:@": %d\n", self.perkProps.BucketSpinner]];
    [mutStr appendString:[NSString stringWithFormat:@": %d\n", self.perkProps.HoopSpinner]];
    [mutStr appendString:[NSString stringWithFormat:@": %d\n", self.perkProps.ClimbingWall]];
    [mutStr appendString:[NSString stringWithFormat:@": %d\n", self.perkProps.BalanceBeam]];
    [mutStr appendString:[NSString stringWithFormat:@": %d\n", self.perkProps.NovelExerciseStations]];
    [mutStr appendString:[NSString stringWithFormat:@": %d\n", self.perkProps.ElectronicGameStations]];
    [mutStr appendString:[NSString stringWithFormat:@": %d\n", self.perkProps.ZipLine]];
    [mutStr appendString:[NSString stringWithFormat:@": %d\n", self.perkProps.MerryGoRound]];
    [mutStr appendString:[NSString stringWithFormat:@": %d\n", self.perkProps.PlaySystem]];
    [mutStr appendString:[NSString stringWithFormat:@": %d\n", self.perkProps.SandDigger]];
    [mutStr appendString:[NSString stringWithFormat:@": %d\n", self.perkProps.SpringRocker]];
    [mutStr appendString:[NSString stringWithFormat:@": %d\n", self.perkProps.Shaded]];
    //
    // ******** Exercises
    [mutStr appendString:[NSString stringWithFormat:@": %d\n", self.perkProps.WalkingJoggingPath]];
    [mutStr appendString:[NSString stringWithFormat:@": %d\n", self.perkProps.ChinUp]];
    [mutStr appendString:[NSString stringWithFormat:@": %d\n", self.perkProps.ExerciseStations]];
    //
    // ******** Nature
    [mutStr appendString:[NSString stringWithFormat:@": %d\n", self.perkProps.Creek]];
    [mutStr appendString:[NSString stringWithFormat:@": %d\n", self.perkProps.Pond]];
    [mutStr appendString:[NSString stringWithFormat:@": %d\n", self.perkProps.Arboretum]];
    [mutStr appendString:[NSString stringWithFormat:@": %d\n", self.perkProps.Ducks]];
    [mutStr appendString:[NSString stringWithFormat:@": %d\n", self.perkProps.Fishing]];
    [mutStr appendString:[NSString stringWithFormat:@": %d\n", self.perkProps.Aviary]];
    //
    // ******** Water
    [mutStr appendString:[NSString stringWithFormat:@": %d\n", self.perkProps.OutdoorPool]];
    [mutStr appendString:[NSString stringWithFormat:@": %d\n", self.perkProps.WaterSlide]];
    [mutStr appendString:[NSString stringWithFormat:@": %d\n", self.perkProps.BabyPool]];
    [mutStr appendString:[NSString stringWithFormat:@": %d\n", self.perkProps.LapSwim]];
    //static NSString *kCreek = @"Creek";
    //static NSString *kPond = @"Pond";
    //static NSString *kSplashPad = @"SplashPad";
    [mutStr appendString:[NSString stringWithFormat:@": %d\n", self.perkProps.DrinkingFountain]];
    [mutStr appendString:[NSString stringWithFormat:@": %d\n", self.perkProps.DivingBoard]];
    [mutStr appendString:[NSString stringWithFormat:@": %d\n", self.perkProps.HighDive]];
    [mutStr appendString:[NSString stringWithFormat:@": %d\n", self.perkProps.WaterNozzle]];
    //
    // ******** Sports
    [mutStr appendString:[NSString stringWithFormat:@": %d\n", self.perkProps.Baseball]];
    [mutStr appendString:[NSString stringWithFormat:@": %d\n", self.perkProps.Soccer]];
    [mutStr appendString:[NSString stringWithFormat:@": %d\n", self.perkProps.Football]];
    [mutStr appendString:[NSString stringWithFormat:@": %d\n", self.perkProps.BasketBall]];
    [mutStr appendString:[NSString stringWithFormat:@": %d\n", self.perkProps.Tennis]];
    [mutStr appendString:[NSString stringWithFormat:@": %d\n", self.perkProps.RaquetBall]];
    [mutStr appendString:[NSString stringWithFormat:@": %d\n", self.perkProps.VolleyBall]];
    [mutStr appendString:[NSString stringWithFormat:@": %d\n", self.perkProps.BMX]];
    [mutStr appendString:[NSString stringWithFormat:@": %d\n", self.perkProps.Skate]];
    [mutStr appendString:[NSString stringWithFormat:@": %d\n", self.perkProps.DiscGolf]];
    [mutStr appendString:[NSString stringWithFormat:@": %d\n", self.perkProps.Bicycling]];
    [mutStr appendString:[NSString stringWithFormat:@": %d\n", self.perkProps.Horshoes]];
    //
    // ******** History
    [mutStr appendString:[NSString stringWithFormat:@": %d\n", self.perkProps.Memorials]];
    //
    // ******** Facilities
    [mutStr appendString:[NSString stringWithFormat:@": %d\n", self.perkProps.Bathroom]];
    [mutStr appendString:[NSString stringWithFormat:@": %d\n", self.perkProps.WaterFountain]];
    [mutStr appendString:[NSString stringWithFormat:@": %d\n", self.perkProps.Electricity]];
    [mutStr appendString:[NSString stringWithFormat:@": %d\n", self.perkProps.Lighting]];
    [mutStr appendString:[NSString stringWithFormat:@": %d\n", self.perkProps.DogsAllowed]];
    [mutStr appendString:[NSString stringWithFormat:@": %d\n", self.perkProps.DogsOffLeashAllowed]];
    [mutStr appendString:[NSString stringWithFormat:@": %d\n", self.perkProps.Drones]];
    [mutStr appendString:[NSString stringWithFormat:@": %d\n", self.perkProps.Kites]];
    [mutStr appendString:[NSString stringWithFormat:@": %d\n", self.perkProps.Surface]];
    [mutStr appendString:[NSString stringWithFormat:@": %d\n", self.perkProps.Shade]];
    //
    // ******** Picnic
    [mutStr appendString:[NSString stringWithFormat:@": %d\n", self.perkProps.BBQGas]];
    [mutStr appendString:[NSString stringWithFormat:@": %d\n", self.perkProps.BBQFirePit]];
    [mutStr appendString:[NSString stringWithFormat:@": %d\n", self.perkProps.BBQCharcoal]];
    [mutStr appendString:[NSString stringWithFormat:@": %d\n", self.perkProps.Shelter]];
    [mutStr appendString:[NSString stringWithFormat:@": %d\n", self.perkProps.Pavilion]];
    [mutStr appendString:[NSString stringWithFormat:@": %d\n", self.perkProps.Ramada]];
    [mutStr appendString:[NSString stringWithFormat:@": %d\n", self.perkProps.AlcoholPermit]];
    [mutStr appendString:[NSString stringWithFormat:@": %d\n", self.perkProps.Seating]];
    
    return mutStr;
}

@end
