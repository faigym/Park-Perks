//
//  Perk.h
//  Park Perks
//
//  Created by Douglas Voss on 5/19/15.
//  Copyright (c) 2015 Skyler Clark. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>
#import "PerkConstants.h"

@interface Perk : NSObject

@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *iconName;
@property (nonatomic, assign) int category;

- (NSString *)toString;

- (void)saveToDatabase;

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
		      
