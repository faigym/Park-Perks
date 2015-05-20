//
//  PerkProperties.h
//  Park Perks
//
//  Created by Douglas Voss on 5/19/15.
//  Copyright (c) 2015 Skyler Clark. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PerkConstants.h"

@interface PerkProperties : NSObject

// ********* Playground
@property (nonatomic, assign) Boolean SeeSaw;
@property (nonatomic, assign) Boolean BabySwing;
@property (nonatomic, assign) Boolean Swings;
@property (nonatomic, assign) Boolean TireSwing;
@property (nonatomic, assign) Boolean TubeSlide;
@property (nonatomic, assign) Boolean OpenSlide;
@property (nonatomic, assign) Boolean ToddlerPlayEquipment;
@property (nonatomic, assign) Boolean ClimbingNet;
@property (nonatomic, assign) Boolean WoodChips;
@property (nonatomic, assign) Boolean Rubber;
@property (nonatomic, assign) Boolean Sand;
@property (nonatomic, assign) Boolean MonkeyBars;
@property (nonatomic, assign) Boolean PreschoolActivities;
@property (nonatomic, assign) Boolean SplashPad;
@property (nonatomic, assign) Boolean BucketSpinner;
@property (nonatomic, assign) Boolean HoopSpinner;
@property (nonatomic, assign) Boolean ClimbingWall;
@property (nonatomic, assign) Boolean BalanceBeam;
@property (nonatomic, assign) Boolean NovelExerciseStations;
@property (nonatomic, assign) Boolean ElectronicGameStations;
@property (nonatomic, assign) Boolean ZipLine;
@property (nonatomic, assign) Boolean MerryGoRound;
@property (nonatomic, assign) Boolean PlaySystem;
@property (nonatomic, assign) Boolean SandDigger;
@property (nonatomic, assign) Boolean SpringRocker;
@property (nonatomic, assign) Boolean Shaded;
//
// ******** Exercises
@property (nonatomic, assign) Boolean WalkingJoggingPath;
@property (nonatomic, assign) Boolean ChinUp;
@property (nonatomic, assign) Boolean ExerciseStations;
//
// ******** Nature
@property (nonatomic, assign) Boolean Creek;
@property (nonatomic, assign) Boolean Pond;
@property (nonatomic, assign) Boolean Arboretum;
@property (nonatomic, assign) Boolean Ducks;
@property (nonatomic, assign) Boolean Fishing;
@property (nonatomic, assign) Boolean Aviary;
//
// ******** Water
@property (nonatomic, assign) Boolean OutdoorPool;
@property (nonatomic, assign) Boolean WaterSlide;
@property (nonatomic, assign) Boolean BabyPool;
@property (nonatomic, assign) Boolean LapSwim;
//static NSString *kCreek = @"Creek";
//static NSString *kPond = @"Pond";
//static NSString *kSplashPad = @"SplashPad";
@property (nonatomic, assign) Boolean DrinkingFountain;
@property (nonatomic, assign) Boolean DivingBoard;
@property (nonatomic, assign) Boolean HighDive;
@property (nonatomic, assign) Boolean WaterNozzle;
//
// ******** Sports
@property (nonatomic, assign) Boolean Baseball;
@property (nonatomic, assign) Boolean Soccer;
@property (nonatomic, assign) Boolean Football;
@property (nonatomic, assign) Boolean BasketBall;
@property (nonatomic, assign) Boolean Tennis;
@property (nonatomic, assign) Boolean RaquetBall;
@property (nonatomic, assign) Boolean VolleyBall;
@property (nonatomic, assign) Boolean BMX;
@property (nonatomic, assign) Boolean Skate;
@property (nonatomic, assign) Boolean DiscGolf;
@property (nonatomic, assign) Boolean Bicycling;
@property (nonatomic, assign) Boolean Horshoes;
//
// ******** History
@property (nonatomic, assign) Boolean Memorials;
//
// ******** Facilities
@property (nonatomic, assign) Boolean Bathroom;
@property (nonatomic, assign) Boolean WaterFountain;
@property (nonatomic, assign) Boolean Electricity;
@property (nonatomic, assign) Boolean Lighting;
@property (nonatomic, assign) Boolean DogsAllowed;
@property (nonatomic, assign) Boolean DogsOffLeashAllowed;
@property (nonatomic, assign) Boolean Drones;
@property (nonatomic, assign) Boolean Kites;
@property (nonatomic, assign) Boolean Surface;
@property (nonatomic, assign) Boolean Shade;
//
// ******** Picnic
@property (nonatomic, assign) Boolean BBQGas;
@property (nonatomic, assign) Boolean BBQFirePit;
@property (nonatomic, assign) Boolean BBQCharcoal;
@property (nonatomic, assign) Boolean Shelter;
@property (nonatomic, assign) Boolean Pavilion;
@property (nonatomic, assign) Boolean Ramada;
@property (nonatomic, assign) Boolean AlcoholPermit;
@property (nonatomic, assign) Boolean Seating;

- (NSDictionary *)sectionContentsForCategory:(NSString *)categoryStr;
			      
@end
