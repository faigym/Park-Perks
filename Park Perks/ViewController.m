//
//  ViewController.m
//  Park Perks
//
//  Created by Skyler Clark on 5/19/15.
//  Copyright (c) 2015 Skyler Clark. All rights reserved.
//

#import "ViewController.h"
#import "ParkModel.h"
#import "Perk.h"

@interface ViewController ()

@end

@implementation ViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSArray *perkNames = @[kWaterFountain, kWoodChips, kOpenSlide, kTubeSlide, kVolleyBall, kSand, kPond, kDucks, kSoccer, kOutdoorPool, kWaterSlide, kChinUp, kWalkingJoggingPath, kExerciseStations, kToddlerPlayEquipment, kBabySwing, kSwings, kTireSwing];
    
    self.view.backgroundColor = [UIColor redColor];
    
    //[self makePerkDatabase];    
    
    // Do any additional setup after loading the view, typically from a nib.
    ParkModel *murrayPark = [[ParkModel alloc] init];
    murrayPark.name = @"Murray Park";
    murrayPark.address = @"296 East Murray Park Avenue,\nMurray, UT 84107";
    murrayPark.latitude = 40.656847;
    murrayPark.longitude = -111.883451;
    murrayPark.phoneNumber = @"(801) 264-2614";

#ifdef STRINGPERKS
    for (int i=0; i<[perkNames count]; i++) {
        Perk *newPerk = [[Perk alloc] init];
        newPerk.name = perkNames[i];
        newPerk.category = enumPlayground;
        
        [murrayPark.perks addObject:newPerk];
    }
#else
#ifdef BOOLARRAYPERKS
    murrayPark.perks = [[NSMutableArray alloc] initWithCapacity:indexMaxEnumCount];
    for (int i=0; i<[murrayPark.perks count]; i++)
    {
        murrayPark.perks[i] = [NSNumber numberWithBool:false];
    }
#else
    murrayPark.perkProps.WoodChips = true;
    murrayPark.perkProps.MonkeyBars = true;
    murrayPark.perkProps.Sand = true;
    murrayPark.perkProps.Pond = true;
    murrayPark.perkProps.ToddlerPlayEquipment = true;
    murrayPark.perkProps.ChinUp = true;
#endif
#endif
    
    //NSLog(@"murray park object == %@", murrayPark);
    //[murrayPark saveToDataBase];

    NSMutableArray *nameStrMutArr = [NSMutableArray new];
    NSMutableArray *isCheckedArr = [NSMutableArray new];
    [murrayPark dataForCategory:kCategoryPlayground nameStringArr:nameStrMutArr isCheckedArr:isCheckedArr];

    for (int i=0; i<[nameStrMutArr count]; i++) {
      NSLog(@"row %d name: %@ isChecked: %d", i, nameStrMutArr[i], [isCheckedArr[i] integerValue]);
    }
}


- (void)makePerkDatabase
{
      Perk *perk = [Perk new];
    perk.name = kSeeSaw;
    perk.iconName = @"icoSeeSaw.png";
    perk.category = enumPlayground;
    [perk saveToDatabase];

    perk.name = kBabySwing;
    perk.iconName = @"icoBabySwing.png";
    perk.category = enumPlayground;
    [perk saveToDatabase];
    
    perk.name = kSwings;
    perk.iconName = @"icoSwings.png";
    perk.category = enumPlayground;
    [perk saveToDatabase];
    
    perk.name = kTireSwing;
    perk.iconName = @"icoTireSwing.png";
    perk.category = enumPlayground;
    [perk saveToDatabase];
    
    perk.name = kTubeSlide;
    perk.iconName = @"icoTubeSlide.png";
    perk.category = enumPlayground;
    [perk saveToDatabase];
    
    perk.name = kOpenSlide;
    perk.iconName = @"icoOpenSlide.png";
    perk.category = enumPlayground;
    [perk saveToDatabase];
    
    perk.name = kToddlerPlayEquipment;
    perk.iconName = @"icoToddlerPlayEquipment.png";
    perk.category = enumPlayground;
    [perk saveToDatabase];
    
    perk.name = kClimbingNet;
    perk.iconName = @"icoClimbingNet.png";
    perk.category = enumPlayground;
    [perk saveToDatabase];
    
    perk.name = kWoodChips;
    perk.iconName = @"icoWoodChips.png";
    perk.category = enumPlayground;
    [perk saveToDatabase];
    
    perk.name = kRubber;
    perk.iconName = @"icoRubber.png";
    perk.category = enumPlayground;
    [perk saveToDatabase];
    
    perk.name = kSand;
    perk.iconName = @"icoSand.png";
    perk.category = enumPlayground;
    [perk saveToDatabase];
    
    perk.name = kMonkeyBars;
    perk.iconName = @"icoMonkeyBars.png";
    perk.category = enumPlayground;
    [perk saveToDatabase];
    
    perk.name = kPreschoolActivities;
    perk.iconName = @"icoPreschoolActivities.png";
    perk.category = enumPlayground;
    [perk saveToDatabase];
    
    perk.name = kSplashPad;
    perk.iconName = @"icoSplashPad.png";
    perk.category = enumPlayground;
    [perk saveToDatabase];
    
    perk.name = kBucketSpinner;
    perk.iconName = @"icoBucketSpinner.png";
    perk.category = enumPlayground;
    [perk saveToDatabase];
    
    perk.name = kHoopSpinner;
    perk.iconName = @"icoHoopSpinner.png";
    perk.category = enumPlayground;
    [perk saveToDatabase];
    
    perk.name = kClimbingWall;
    perk.iconName = @"icoClimbingWall.png";
    perk.category = enumPlayground;
    [perk saveToDatabase];
    
    perk.name = kBalanceBeam;
    perk.iconName = @"icoBalanceBeam.png";
    perk.category = enumPlayground;
    [perk saveToDatabase];
    
    perk.name = kNovelExerciseStations;
    perk.iconName = @"icoNovelExerciseStations.png";
    perk.category = enumPlayground;
    [perk saveToDatabase];
    
    perk.name = kElectronicGameStations;
    perk.iconName = @"icoElectronicGameStations.png";
    perk.category = enumPlayground;
    [perk saveToDatabase];
    
    perk.name = kZipLine;
    perk.iconName = @"icoZipLine.png";
    perk.category = enumPlayground;
    [perk saveToDatabase];
    
    perk.name = kMerryGoRound;
    perk.iconName = @"icoMerryGoRound.png";
    perk.category = enumPlayground;
    [perk saveToDatabase];
    
    perk.name = kPlaySystem;
    perk.iconName = @"icoPlaySystem.png";
    perk.category = enumPlayground;
    [perk saveToDatabase];
    
    perk.name = kSandDigger;
    perk.iconName = @"icoSandDigger.png";
    perk.category = enumPlayground;
    [perk saveToDatabase];
    
    perk.name = kSpringRocker;
    perk.iconName = @"icoSpringRocker.png";
    perk.category = enumPlayground;
    [perk saveToDatabase];
    
    perk.name = kShaded;
    perk.iconName = @"icoShaded.png";
    perk.category = enumPlayground;
    [perk saveToDatabase];
    
    perk.name = kWalkingJoggingPath;
    perk.iconName = @"icoWalkingJoggingPath.png";
    perk.category = enumExercise;
    [perk saveToDatabase];
    
    perk.name = kChinUp;
    perk.iconName = @"icoChinUp.png";
    perk.category = enumExercise;
    [perk saveToDatabase];
    
    perk.name = kExerciseStations;
    perk.iconName = @"icoExerciseStations.png";
    perk.category = enumExercise;
    [perk saveToDatabase];
    
    perk.name = kCreek;
    perk.iconName = @"icoCreek.png";
    perk.category = enumNature | enumWater;
    [perk saveToDatabase];
    
    perk.name = kPond;
    perk.iconName = @"icoPond.png";
    perk.category = enumNature | enumWater;
    [perk saveToDatabase];
    
    perk.name = kArboretum;
    perk.iconName = @"icoArboretum.png";
    perk.category = enumNature;
    [perk saveToDatabase];
    
    perk.name = kDucks;
    perk.iconName = @"icoDucks.png";
    perk.category = enumNature | enumWater;
    [perk saveToDatabase];
    
    perk.name = kFishing;
    perk.iconName = @"icoFishing.png";
    perk.category = enumNature | enumWater;
    [perk saveToDatabase];
    
    perk.name = kAviary;
    perk.iconName = @"icoAviary.png";
    perk.category = enumNature;
    [perk saveToDatabase];
    
    perk.name = kOutdoorPool;
    perk.iconName = @"icoOutdoorPool.png";
    perk.category = enumWater | enumSports;
    [perk saveToDatabase];
    
    perk.name = kWaterSlide;
    perk.iconName = @"icoWaterSlide.png";
    perk.category = enumWater;
    [perk saveToDatabase];
    
    perk.name = kBabyPool;
    perk.iconName = @"icoBabyPool.png";
    perk.category = enumWater;
    [perk saveToDatabase];
    
    perk.name = kLapSwim;
    perk.iconName = @"icoLapSwim.png";
    perk.category = enumWater;
    [perk saveToDatabase];
    
    perk.name = kDrinkingFountain;
    perk.iconName = @"icoDrinkingFountain.png";
    perk.category = enumFacilities;
    [perk saveToDatabase];
    
    perk.name = kDivingBoard;
    perk.iconName = @"icoDivingBoard.png";
    perk.category = enumWater;
    [perk saveToDatabase];
    
    perk.name = kHighDive;
    perk.iconName = @"icoHighDive.png";
    perk.category = enumWater;
    [perk saveToDatabase];
    
    perk.name = kWaterNozzle;
    perk.iconName = @"icoWaterNozzle.png";
    perk.category = enumWater;
    [perk saveToDatabase];
    
    perk.name = kBaseball;
    perk.iconName = @"icoBaseball.png";
    perk.category = enumSports;
    [perk saveToDatabase];
    
    perk.name = kSoccer;
    perk.iconName = @"icoSoccer.png";
    perk.category = enumSports;
    [perk saveToDatabase];
    
    perk.name = kFootball;
    perk.iconName = @"icoFootball.png";
    perk.category = enumSports;
    [perk saveToDatabase];
    
    perk.name = kBasketBall;
    perk.iconName = @"icoBasketBall.png";
    perk.category = enumSports;
    [perk saveToDatabase];
    
    perk.name = kTennis;
    perk.iconName = @"icoTennis.png";
    perk.category = enumSports;
    [perk saveToDatabase];
    
    perk.name = kRaquetBall;
    perk.iconName = @"icoRaquetBall.png";
    perk.category = enumSports;
    [perk saveToDatabase];
    
    perk.name = kVolleyBall;
    perk.iconName = @"icoVolleyBall.png";
    perk.category = enumSports;
    [perk saveToDatabase];
    
    perk.name = kBMX;
    perk.iconName = @"icoBMX.png";
    perk.category = enumSports;
    [perk saveToDatabase];
    
    perk.name = kSkate;
    perk.iconName = @"icoSkate.png";
    perk.category = enumSports;
    [perk saveToDatabase];
    
    perk.name = kDiscGolf;
    perk.iconName = @"icoDiscGolf.png";
    perk.category = enumSports;
    [perk saveToDatabase];
    
    perk.name = kBicycling;
    perk.iconName = @"icoBicycling.png";
    perk.category = enumSports;
    [perk saveToDatabase];
    
    perk.name = kHorshoes;
    perk.iconName = @"icoHorshoes.png";
    perk.category = enumSports;
    [perk saveToDatabase];
    
    perk.name = kMemorials;
    perk.iconName = @"icoMemorials.png";
    perk.category = enumHistory;
    [perk saveToDatabase];
    
    perk.name = kBathroom;
    perk.iconName = @"icoBathroom.png";
    perk.category = enumFacilities;
    [perk saveToDatabase];
    
    perk.name = kWaterFountain;
    perk.iconName = @"icoWaterFountain.png";
    perk.category = enumFacilities;
    [perk saveToDatabase];
    
    perk.name = kElectricity;
    perk.iconName = @"icoElectricity.png";
    perk.category = enumFacilities;
    [perk saveToDatabase];
    
    perk.name = kLighting;
    perk.iconName = @"icoLighting.png";
    perk.category = enumFacilities;
    [perk saveToDatabase];
    
    perk.name = kDogsAllowed;
    perk.iconName = @"icoDogsAllowed.png";
    perk.category = enumFacilities;
    [perk saveToDatabase];
    
    perk.name = kDogsOffLeashAllowed;
    perk.iconName = @"icoDogsOffLeashAllowed.png";
    perk.category = enumFacilities;
    [perk saveToDatabase];
    
    perk.name = kDrones;
    perk.iconName = @"icoDrones.png";
    perk.category = enumFacilities;
    [perk saveToDatabase];
    
    perk.name = kKites;
    perk.iconName = @"icoKites.png";
    perk.category = enumFacilities;
    [perk saveToDatabase];
    
    perk.name = kSurface;
    perk.iconName = @"icoSurface.png";
    perk.category = enumFacilities;
    [perk saveToDatabase];
    
    perk.name = kShade;
    perk.iconName = @"icoShade.png";
    perk.category = enumPicnic;
    [perk saveToDatabase];
    
    perk.name = kBBQGas;
    perk.iconName = @"icoBBQGas.png";
    perk.category = enumPicnic;
    [perk saveToDatabase];
    
    perk.name = kBBQFirePit;
    perk.iconName = @"icoBBQFirePit.png";
    perk.category = enumPicnic;
    [perk saveToDatabase];
    
    perk.name = kBBQCharcoal;
    perk.iconName = @"icoBBQCharcoal.png";
    perk.category = enumPicnic;
    [perk saveToDatabase];
    
    perk.name = kShelter;
    perk.iconName = @"icoShelter.png";
    perk.category = enumPicnic;
    [perk saveToDatabase];
    
    perk.name = kPavilion;
    perk.iconName = @"icoPavilion.png";
    perk.category = enumPicnic;
    [perk saveToDatabase];
    
    perk.name = kRamada;
    perk.iconName = @"icoRamada.png";
    perk.category = enumPicnic;
    [perk saveToDatabase];
    
    perk.name = kAlcoholPermit;
    perk.iconName = @"icoAlcoholPermit.png";
    perk.category = enumPicnic;
    [perk saveToDatabase];
    
    perk.name = kSeating;
    perk.iconName = @"icoSeating.png";
    perk.category = enumPicnic;
    [perk saveToDatabase];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
