//
//  PerkProperties.h
//  Park Perks
//
//  Created by Douglas Voss on 5/19/15.
//  Copyright (c) 2015 Skyler Clark. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PerkProperties : NSObject

// ********* Playground
@property (nonatomic, assign) BOOL SeeSaw;
@property (nonatomic, assign) BOOL BabySwing;
@property (nonatomic, assign) BOOL Swings;
@property (nonatomic, assign) BOOL TireSwing;
@property (nonatomic, assign) BOOL TubeSlide;
@property (nonatomic, assign) BOOL OpenSlide;
@property (nonatomic, assign) BOOL ToddlerPlayEquipment;
@property (nonatomic, assign) BOOL ClimbingNet;
@property (nonatomic, assign) BOOL WoodChips;
@property (nonatomic, assign) BOOL Rubber;
@property (nonatomic, assign) BOOL Sand;
@property (nonatomic, assign) BOOL MonkeyBars;
@property (nonatomic, assign) BOOL PreschoolActivities;
@property (nonatomic, assign) BOOL SplashPad;
@property (nonatomic, assign) BOOL BucketSpinner;
@property (nonatomic, assign) BOOL HoopSpinner;
@property (nonatomic, assign) BOOL ClimbingWall;
@property (nonatomic, assign) BOOL BalanceBeam;
@property (nonatomic, assign) BOOL NovelExerciseStations;
@property (nonatomic, assign) BOOL ElectronicGameStations;
@property (nonatomic, assign) BOOL ZipLine;
@property (nonatomic, assign) BOOL MerryGoRound;
@property (nonatomic, assign) BOOL PlaySystem;
@property (nonatomic, assign) BOOL SandDigger;
@property (nonatomic, assign) BOOL SpringRocker;
@property (nonatomic, assign) BOOL Shaded;
//
// ******** Exercises
@property (nonatomic, assign) BOOL WalkingJoggingPath;
@property (nonatomic, assign) BOOL ChinUp;
@property (nonatomic, assign) BOOL ExerciseStations;
//
// ******** Nature
@property (nonatomic, assign) BOOL Creek;
@property (nonatomic, assign) BOOL Pond;
@property (nonatomic, assign) BOOL Arboretum;
@property (nonatomic, assign) BOOL Ducks;
@property (nonatomic, assign) BOOL Fishing;
@property (nonatomic, assign) BOOL Aviary;
//
// ******** Water
@property (nonatomic, assign) BOOL OutdoorPool;
@property (nonatomic, assign) BOOL WaterSlide;
@property (nonatomic, assign) BOOL BabyPool;
@property (nonatomic, assign) BOOL LapSwim;
//static NSString *kCreek = @"Creek";
//static NSString *kPond = @"Pond";
//static NSString *kSplashPad = @"SplashPad";
@property (nonatomic, assign) BOOL DrinkingFountain;
@property (nonatomic, assign) BOOL DivingBoard;
@property (nonatomic, assign) BOOL HighDive;
@property (nonatomic, assign) BOOL WaterNozzle;
//
// ******** Sports
@property (nonatomic, assign) BOOL Baseball;
@property (nonatomic, assign) BOOL Soccer;
@property (nonatomic, assign) BOOL Football;
@property (nonatomic, assign) BOOL BasketBall;
@property (nonatomic, assign) BOOL Tennis;
@property (nonatomic, assign) BOOL RaquetBall;
@property (nonatomic, assign) BOOL VolleyBall;
@property (nonatomic, assign) BOOL BMX;
@property (nonatomic, assign) BOOL Skate;
@property (nonatomic, assign) BOOL DiscGolf;
@property (nonatomic, assign) BOOL Bicycling;
@property (nonatomic, assign) BOOL Horshoes;
//
// ******** History
@property (nonatomic, assign) BOOL Memorials;
//
// ******** Facilities
@property (nonatomic, assign) BOOL Bathroom;
@property (nonatomic, assign) BOOL WaterFountain;
@property (nonatomic, assign) BOOL Electricity;
@property (nonatomic, assign) BOOL Lighting;
@property (nonatomic, assign) BOOL DogsAllowed;
@property (nonatomic, assign) BOOL DogsOffLeashAllowed;
@property (nonatomic, assign) BOOL Drones;
@property (nonatomic, assign) BOOL Kites;
@property (nonatomic, assign) BOOL Surface;
@property (nonatomic, assign) BOOL Shade;
//
// ******** Picnic
@property (nonatomic, assign) BOOL BBQGas;
@property (nonatomic, assign) BOOL BBQFirePit;
@property (nonatomic, assign) BOOL BBQCharcoal;
@property (nonatomic, assign) BOOL Shelter;
@property (nonatomic, assign) BOOL Pavilion;
@property (nonatomic, assign) BOOL Ramada;
@property (nonatomic, assign) BOOL AlcoholPermit;
@property (nonatomic, assign) BOOL Seating;

- (NSDictionary *)sectionContentsForCategory:(NSString *)categoryStr;

- (void)setPerk;
- (BOOL)getPerk;

@end
