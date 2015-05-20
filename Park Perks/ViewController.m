//
//  ViewController.m
//  Park Perks
//
//  Created by Skyler Clark on 5/19/15.
//  Copyright (c) 2015 Skyler Clark. All rights reserved.
//

#import "ViewController.h"
#import "ParkModel.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSArray *perkNames = @[kWaterFountain, kWoodChips, kOpenSlide, kTubeSlide, kVolleyBall, kSand, kPond, kDucks, kSoccer, kOutdoorPool, kWaterSlide, kChinUp, kWalkingJoggingPath, kExerciseStations, kToddlerPlayEquipment, kBabySwing, kSwings, kTireSwing];
    
    self.view.backgroundColor = [UIColor redColor];
    
    // Do any additional setup after loading the view, typically from a nib.
    ParkModel *murrayPark = [[ParkModel alloc] init];
    murrayPark.name = @"Murray Park";
    murrayPark.address = @"296 East Murray Park Avenue,\nMurray, UT 84107";
    murrayPark.latitude = 40.656847;
    murrayPark.longitude = -111.883451;
    murrayPark.phoneNumber = @"(801) 264-2614";
    
    for (int i=0; i<[perkNames count]; i++) {
        Perk *newPerk = [[Perk alloc] init];
        newPerk.name = perkNames[i];
        newPerk.category = enumPlayground;
        
        [murrayPark.perks addObject:newPerk];
    }
    
    NSLog(@"murray park object == %@", murrayPark);
    //[murrayPark saveToDataBase];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
