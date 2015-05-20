#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#ifndef PERKCONSTANTS
#define PERKCONSTANTS

static NSString *kCategoryPlayground = @"CategoryPlayground";
static NSString *kCategoryExercises  = @"CategoryExercises";
static NSString *kCategoryNature     = @"CategoryNature";
static NSString *kCategoryWater      = @"CategoryWater";
static NSString *kCategorySports     = @"CategorySports";
static NSString *kCategoryHistory    = @"CategoryHistory";
static NSString *kCategoryFacilities = @"CategoryFacilities";
static NSString *kCategoryPicnic     = @"CategoryPicnic";

typedef enum PerkIndexEnumType : NSUInteger
{
  indexSeeSaw,
    indexBabySwing,
    indexSwings,
    indexTireSwing,
    indexTubeSlide,
    indexOpenSlide,
    indexToddlerPlayEquipment,
    indexClimbingNet,
    indexWoodChips,
    indexRubber,
    indexSand,
    indexMonkeyBars,
    indexPreschoolActivities,
    indexSplashPad,
    indexBucketSpinner,
    indexHoopSpinner,
    indexClimbingWall,
    indexBalanceBeam,
    indexNovelExerciseStations,
    indexElectronicGameStations,
    indexZipLine,
    indexMerryGoRound,
    indexPlaySystem,
    indexSandDigger,
    indexSpringRocker,
    indexShaded,
    indexWalkingJoggingPath,
    indexChinUp,
    indexExerciseStations,
    indexCreek,
    indexPond,
    indexArboretum,
    indexDucks,
    indexFishing,
    indexAviary,
    indexOutdoorPool,
    indexWaterSlide,
    indexBabyPool,
    indexLapSwim,
    indexDrinkingFountain,
    indexDivingBoard,
    indexHighDive,
    indexWaterNozzle,
    indexBaseball,
    indexSoccer,
    indexFootball,
    indexBasketBall,
    indexTennis,
    indexRaquetBall,
    indexVolleyBall,
    indexBMX,
    indexSkate,
    indexDiscGolf,
    indexBicycling,
    indexHorshoes,
    indexMemorials,
    indexBathroom,
    indexWaterFountain,
    indexElectricity,
    indexLighting,
    indexDogsAllowed,
    indexDogsOffLeashAllowed,
    indexDrones,
    indexKites,
    indexSurface,
    indexShade,
    indexBBQGas,
    indexBBQFirePit,
    indexBBQCharcoal,
    indexShelter,
    indexPavilion,
    indexRamada,
    indexAlcoholPermit,
    indexSeating,
    indexMaxEnumCount
} PerkIndexEnumType;

//static NSString *kPerkSeeSaw    = @"seeSaw";
// ******** Playground		      
static NSString *kSeeSaw = @"SeeSaw";
static NSString *kBabySwing = @"BabySwing";
static NSString *kSwings = @"Swings";
static NSString *kTireSwing = @"TireSwing";
static NSString *kTubeSlide = @"TubeSlide";
static NSString *kOpenSlide = @"OpenSlide";
static NSString *kToddlerPlayEquipment = @"ToddlerPlayEquipment";
static NSString *kClimbingNet = @"ClimbingNet";
static NSString *kWoodChips = @"WoodChips";
static NSString *kRubber = @"Rubber";
static NSString *kSand = @"Sand";
static NSString *kMonkeyBars = @"MonkeyBars";
static NSString *kPreschoolActivities = @"PreschoolActivities";
static NSString *kSplashPad = @"SplashPad";
static NSString *kBucketSpinner = @"BucketSpinner";
static NSString *kHoopSpinner = @"HoopSpinner";
static NSString *kClimbingWall = @"ClimbingWall";
static NSString *kBalanceBeam = @"BalanceBeam";
static NSString *kNovelExerciseStations = @"NovelExerciseStations";
static NSString *kElectronicGameStations = @"ElectronicGameStations";
static NSString *kZipLine = @"ZipLine";
static NSString *kMerryGoRound = @"MerryGoRound";
static NSString *kPlaySystem = @"PlaySystem";
static NSString *kSandDigger = @"SandDigger";
static NSString *kSpringRocker = @"SpringRocker";
static NSString *kShaded = @"Shaded";
//
// ******** Exercises
static NSString *kWalkingJoggingPath = @"WalkingJoggingPath";
static NSString *kChinUp = @"ChinUp";
static NSString *kExerciseStations = @"ExerciseStations";
//
// ******** Nature
static NSString *kCreek = @"Creek";
static NSString *kPond = @"Pond";
static NSString *kArboretum = @"Arboretum";
static NSString *kDucks = @"Ducks";
static NSString *kFishing = @"Fishing";
static NSString *kAviary = @"Aviary";
//
// ******** Water
static NSString *kOutdoorPool = @"OutdoorPool";
static NSString *kWaterSlide = @"WaterSlide";
static NSString *kBabyPool = @"BabyPool";
static NSString *kLapSwim = @"LapSwim";
//static NSString *kCreek = @"Creek";
//static NSString *kPond = @"Pond";
//static NSString *kSplashPad = @"SplashPad";
static NSString *kDrinkingFountain = @"DrinkingFountain";
static NSString *kDivingBoard = @"DivingBoard";
static NSString *kHighDive = @"HighDive";
static NSString *kWaterNozzle = @"WaterNozzle";
//
// ******** Sports
static NSString *kBaseball = @"Baseball";
static NSString *kSoccer = @"Soccer";
static NSString *kFootball = @"Football";
static NSString *kBasketBall = @"BasketBall";
static NSString *kTennis = @"Tennis";
static NSString *kRaquetBall = @"RaquetBall";
static NSString *kVolleyBall = @"VolleyBall";
static NSString *kBMX = @"BMX";
static NSString *kSkate = @"Skate";
static NSString *kDiscGolf = @"DiscGolf";
static NSString *kBicycling = @"Bicycling";
static NSString *kHorshoes = @"Horshoes";
//
// ******** History
static NSString *kMemorials = @"Memorials";
//
// ******** Facilities
static NSString *kBathroom = @"Bathroom";
static NSString *kWaterFountain = @"WaterFountain";
static NSString *kElectricity = @"Electricity";
static NSString *kLighting = @"Lighting";
static NSString *kDogsAllowed = @"DogsAllowed";
static NSString *kDogsOffLeashAllowed = @"DogsOffLeashAllowed";
static NSString *kDrones = @"Drones";
static NSString *kKites = @"Kites";
static NSString *kSurface = @"Surface";
static NSString *kShade = @"Shade";
//
// ******** Picnic
static NSString *kBBQGas = @"BBQGas";
static NSString *kBBQFirePit = @"BBQFirePit";
static NSString *kBBQCharcoal = @"BBQCharcoal";
static NSString *kShelter = @"Shelter";
static NSString *kPavilion = @"Pavilion";
static NSString *kRamada = @"Ramada";
static NSString *kAlcoholPermit = @"AlcoholPermit";
static NSString *kSeating = @"Seating";

typedef enum CategoryType : NSUInteger
{
    enumPlayground = (1<<0),
    enumExercise = (1<<1),
    enumNature = (1<<2),
    enumWater = (1<<3),
    enumSports = (1<<4),
    enumHistory = (1<<5),
    enumFacilities = (1<<6),
    enumPicnic = (1<<7)  
} CategoryType;

#endif
