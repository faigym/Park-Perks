//
//  PerkProperties.m
//  Park Perks
//
//  Created by Douglas Voss on 5/19/15.
//  Copyright (c) 2015 Skyler Clark. All rights reserved.
//

#import "PerkConstants.h"
#import "PerkProperties.h"

@implementation PerkProperties

- (instancetype)init {
  self = [super init];
  if (self) {
      self.SeeSaw = false;
      self.BabySwing = false;
      self.Swings = false;
      self.TireSwing = false;
      self.TubeSlide = false;
      self.OpenSlide = false;
      self.ToddlerPlayEquipment = false;
      self.ClimbingNet = false;
      self.WoodChips = false;
      self.Rubber = false;
      self.Sand = false;
      self.MonkeyBars = false;
      self.PreschoolActivities = false;
      self.SplashPad = false;
      self.BucketSpinner = false;
      self.HoopSpinner = false;
      self.ClimbingWall = false;
      self.BalanceBeam = false;
      self.NovelExerciseStations = false;
      self.ElectronicGameStations = false;
      self.ZipLine = false;
      self.MerryGoRound = false;
      self.PlaySystem = false;
      self.SandDigger = false;
      self.SpringRocker = false;
      self.Shaded = false;

      self.WalkingJoggingPath = false;
      self.ChinUp = false;
      self.ExerciseStations = false;

      self.Creek = false;
      self.Pond = false;
      self.Arboretum = false;
      self.Ducks = false;
      self.Fishing = false;
      self.Aviary = false;

      self.OutdoorPool = false;
      self.WaterSlide = false;
      self.BabyPool = false;
      self.LapSwim = false;

      self.SplashPad = false;
      self.DrinkingFountain = false;
      self.DivingBoard = false;
      self.HighDive = false;
      self.WaterNozzle = false;

      self.Baseball = false;
      self.Soccer = false;
      self.Football = false;
      self.BasketBall = false;
      self.Tennis = false;
      self.RaquetBall = false;
      self.VolleyBall = false;
      self.BMX = false;
      self.Skate = false;
      self.DiscGolf = false;
      self.Bicycling = false;
      self.Horshoes = false;

      self.Memorials = false;

      self.Bathroom = false;
      self.WaterFountain = false;
      self.Electricity = false;
      self.Lighting = false;
      self.DogsAllowed = false;
      self.DogsOffLeashAllowed = false;
      self.Drones = false;
      self.Kites = false;
      self.Surface = false;
      self.Shade = false;

      self.BBQGas = false;
      self.BBQFirePit = false;
      self.BBQCharcoal = false;
      self.Shelter = false;
      self.Pavilion = false;
      self.Ramada = false;
      self.AlcoholPermit = false;
      self.Seating = false;
  }
  return self;
}

    
- (NSDictionary *)sectionContentsForCategory:(NSString *)categoryStr
{
     NSMutableDictionary *retDict = [NSMutableDictionary new];

     if ([categoryStr isEqualToString:kCategoryPlayground])
     {
       [retDict setValue:[NSNumber numberWithBool:self.SeeSaw] forKey:kSeeSaw];
       [retDict setValue:[NSNumber numberWithBool:self.BabySwing] forKey:kBabySwing];
       [retDict setValue:[NSNumber numberWithBool:self.Swings] forKey:kSwings];
       [retDict setValue:[NSNumber numberWithBool:self.TireSwing] forKey:kTireSwing];
       [retDict setValue:[NSNumber numberWithBool:self.TubeSlide] forKey:kTubeSlide];
       [retDict setValue:[NSNumber numberWithBool:self.OpenSlide] forKey:kOpenSlide];
       [retDict setValue:[NSNumber numberWithBool:self.ToddlerPlayEquipment] forKey:kToddlerPlayEquipment];
       [retDict setValue:[NSNumber numberWithBool:self.ClimbingNet] forKey:kClimbingNet];
       [retDict setValue:[NSNumber numberWithBool:self.WoodChips] forKey:kWoodChips];
       [retDict setValue:[NSNumber numberWithBool:self.Rubber] forKey:kRubber];
       [retDict setValue:[NSNumber numberWithBool:self.Sand] forKey:kSand];
       [retDict setValue:[NSNumber numberWithBool:self.MonkeyBars] forKey:kMonkeyBars];
       [retDict setValue:[NSNumber numberWithBool:self.PreschoolActivities] forKey:kPreschoolActivities];
       [retDict setValue:[NSNumber numberWithBool:self.SplashPad] forKey:kSplashPad];
       [retDict setValue:[NSNumber numberWithBool:self.BucketSpinner] forKey:kBucketSpinner];
       [retDict setValue:[NSNumber numberWithBool:self.HoopSpinner] forKey:kHoopSpinner];
       [retDict setValue:[NSNumber numberWithBool:self.ClimbingWall] forKey:kClimbingWall];
       [retDict setValue:[NSNumber numberWithBool:self.BalanceBeam] forKey:kBalanceBeam];
       [retDict setValue:[NSNumber numberWithBool:self.NovelExerciseStations] forKey:kNovelExerciseStations];
       [retDict setValue:[NSNumber numberWithBool:self.ElectronicGameStations] forKey:kElectronicGameStations];
       [retDict setValue:[NSNumber numberWithBool:self.ZipLine] forKey:kZipLine];
       [retDict setValue:[NSNumber numberWithBool:self.MerryGoRound] forKey:kMerryGoRound];
       [retDict setValue:[NSNumber numberWithBool:self.PlaySystem] forKey:kPlaySystem];
       [retDict setValue:[NSNumber numberWithBool:self.SandDigger] forKey:kSandDigger];
       [retDict setValue:[NSNumber numberWithBool:self.SpringRocker] forKey:kSpringRocker];
       [retDict setValue:[NSNumber numberWithBool:self.Shaded] forKey:kShaded];       
     }
     else if ([categoryStr isEqualToString:kCategoryExercises])
     {
       [retDict setValue:[NSNumber numberWithBool:self.WalkingJoggingPath] forKey:kWalkingJoggingPath];
       [retDict setValue:[NSNumber numberWithBool:self.ChinUp] forKey:kChinUp];
       [retDict setValue:[NSNumber numberWithBool:self.ExerciseStations] forKey:kExerciseStations];
     }
     else if ([categoryStr isEqualToString:kCategoryNature])
     {
       [retDict setValue:[NSNumber numberWithBool:self.Creek] forKey:kCreek];
       [retDict setValue:[NSNumber numberWithBool:self.Pond] forKey:kPond];
       [retDict setValue:[NSNumber numberWithBool:self.Arboretum] forKey:kArboretum];
       [retDict setValue:[NSNumber numberWithBool:self.Ducks] forKey:kDucks];
       [retDict setValue:[NSNumber numberWithBool:self.Fishing] forKey:kFishing];
       [retDict setValue:[NSNumber numberWithBool:self.Aviary] forKey:kAviary];
     }     
     else if ([categoryStr isEqualToString:kCategoryWater])
     {
       [retDict setValue:[NSNumber numberWithBool:self.OutdoorPool] forKey:kOutdoorPool];
       [retDict setValue:[NSNumber numberWithBool:self.WaterSlide] forKey:kWaterSlide];
       [retDict setValue:[NSNumber numberWithBool:self.BabyPool] forKey:kBabyPool];
       [retDict setValue:[NSNumber numberWithBool:self.LapSwim] forKey:kLapSwim];
       [retDict setValue:[NSNumber numberWithBool:self.Creek] forKey:kCreek];
       [retDict setValue:[NSNumber numberWithBool:self.Pond] forKey:kPond];
       [retDict setValue:[NSNumber numberWithBool:self.SplashPad] forKey:kSplashPad];
       [retDict setValue:[NSNumber numberWithBool:self.DrinkingFountain] forKey:kDrinkingFountain];
       [retDict setValue:[NSNumber numberWithBool:self.DivingBoard] forKey:kDivingBoard];
       [retDict setValue:[NSNumber numberWithBool:self.HighDive] forKey:kHighDive];
       [retDict setValue:[NSNumber numberWithBool:self.WaterNozzle] forKey:kWaterNozzle];
     }
     else if ([categoryStr isEqualToString:kCategorySports])
     {
       [retDict setValue:[NSNumber numberWithBool:self.Baseball] forKey:kBaseball];
       [retDict setValue:[NSNumber numberWithBool:self.Soccer] forKey:kSoccer];
       [retDict setValue:[NSNumber numberWithBool:self.Football] forKey:kFootball];
       [retDict setValue:[NSNumber numberWithBool:self.BasketBall] forKey:kBasketBall];
       [retDict setValue:[NSNumber numberWithBool:self.Tennis] forKey:kTennis];
       [retDict setValue:[NSNumber numberWithBool:self.RaquetBall] forKey:kRaquetBall];
       [retDict setValue:[NSNumber numberWithBool:self.VolleyBall] forKey:kVolleyBall];
       [retDict setValue:[NSNumber numberWithBool:self.BMX] forKey:kBMX];
       [retDict setValue:[NSNumber numberWithBool:self.Skate] forKey:kSkate];
       [retDict setValue:[NSNumber numberWithBool:self.DiscGolf] forKey:kDiscGolf];
       [retDict setValue:[NSNumber numberWithBool:self.Bicycling] forKey:kBicycling];
       [retDict setValue:[NSNumber numberWithBool:self.Horshoes] forKey:kHorshoes];
     }
     else if ([categoryStr isEqualToString:kCategoryHistory])
     {
       [retDict setValue:[NSNumber numberWithBool:self.Memorials] forKey:kMemorials];       
     }
     else if ([categoryStr isEqualToString:kCategoryFacilities])
     {
       [retDict setValue:[NSNumber numberWithBool:self.Bathroom] forKey:kBathroom];
       [retDict setValue:[NSNumber numberWithBool:self.WaterFountain] forKey:kWaterFountain];
       [retDict setValue:[NSNumber numberWithBool:self.Electricity] forKey:kElectricity];
       [retDict setValue:[NSNumber numberWithBool:self.Lighting] forKey:kLighting];
       [retDict setValue:[NSNumber numberWithBool:self.DogsAllowed] forKey:kDogsAllowed];
       [retDict setValue:[NSNumber numberWithBool:self.DogsOffLeashAllowed] forKey:kDogsOffLeashAllowed];
       [retDict setValue:[NSNumber numberWithBool:self.Drones] forKey:kDrones];
       [retDict setValue:[NSNumber numberWithBool:self.Kites] forKey:kKites];
       [retDict setValue:[NSNumber numberWithBool:self.Surface] forKey:kSurface];
       [retDict setValue:[NSNumber numberWithBool:self.Shade] forKey:kShade];       
     }
     else if ([categoryStr isEqualToString:kCategoryPicnic])
     {
       [retDict setValue:[NSNumber numberWithBool:self.BBQGas] forKey:kBBQGas];
       [retDict setValue:[NSNumber numberWithBool:self.BBQFirePit] forKey:kBBQFirePit];
       [retDict setValue:[NSNumber numberWithBool:self.BBQCharcoal] forKey:kBBQCharcoal];
       [retDict setValue:[NSNumber numberWithBool:self.Shelter] forKey:kShelter];
       [retDict setValue:[NSNumber numberWithBool:self.Pavilion] forKey:kPavilion];
       [retDict setValue:[NSNumber numberWithBool:self.Ramada] forKey:kRamada];
       [retDict setValue:[NSNumber numberWithBool:self.AlcoholPermit] forKey:kAlcoholPermit];
       [retDict setValue:[NSNumber numberWithBool:self.Seating] forKey:kSeating];
     }
     else
     {
          NSLog(@"Invalid category");
     }	 
     
    return retDict;
}

/*- (void)setPerk:(NSString *)perkName toBool:(BOOL)setVal
{
    
}

- (BOOL)getPerk:(NSString *)perkName
{
    
    return YES;
}*/

@end
