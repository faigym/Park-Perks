//
//  Perk.h
//  Park Perks
//
//  Created by Douglas Voss on 5/19/15.
//  Copyright (c) 2015 Skyler Clark. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>

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
static NSString *kBaseball = @"Baseball/Softball";
static NSString *kSoccer = @"Soccer";
static NSString *kFootball = @"Football";
static NSString *kBasketBall = @"BasketBall";
static NSString *kTennis = @"Tennis";
static NSString *kRaquetBall = @"RaquetBall";
static NSString *kVolleyBall = @"VolleyBall";
static NSString *kBMX = @"BMX";
static NSString *kSkate = @"Skate";
static NSString *kDiscGolf = @"Disc Golf";
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

@interface Perk : NSObject

@property (nonatomic, strong) NSString *name;
@property (nonatomic, assign) CategoryType category;

- (NSString *)toString;

@end


// Perks
// ******** Playground		      
// seeSaw
// babySwing
// swings
// tireSwing
// tubeSlide
// openSlide
// toddlerPlayEquipment
// climbingNet
// woodChips
// rubber
// sand
// monkeyBars
// preschoolActivities
// splashPad
// bucketSpinner
// hoopSpinner
// climbingWall
// balanceBeam
// novelExerciseStations
// electronicGameStations
// zipLine
// merryGoRound
// playSystem
// sandDigger
// springRocker
// shaded
//
// ******** Exercises
// walkingJoggingPath
// chinUp
// exerciseStations
//
// ******** Nature
// creek
// pond
// arboretum
// ducks
// fishing
// aviary
//
// ******** Water
// outdoorPool
// waterSlide
// babyPool
// lapSwim
// //creek
// //pond
// splashPad
// drinkingFountain
// divingBoard
// highDive
// waterNozzle
//
// ******** Sports
// Baseball/Softball
// Soccer
// Football
// BasketBall
// Tennis
// RaquetBall
// VolleyBall
// BMX
// Skate
// Disc Golf
// Bicycling
// Horshoes
//
// ******** History
// Memorials
//
// ******** Facilities
// Bathroom
// WaterFountain
// Electricity
// Lighting
// DogsAllowed
// DogsOffLeashAllowed
// Drones
// Kites
// Surface
// Shade
//
// ******** Picnic
// BBQ Gas
// BBQ Fire Pit
// BBQ Charcoal
// Shelter
// Pavilion
// Ramada
// Alcohol Permit
// Seating
		      
