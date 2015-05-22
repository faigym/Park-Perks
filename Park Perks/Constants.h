//
//  Constants.h
//  Park Perks
//
//  Created by Douglas Voss on 5/20/15.
//  Copyright (c) 2015 Skyler Clark. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PerkPropLUTPFObject.h"

// ******** Playground
static NSString *kCategoryPlayground = @"Playground";
static NSString *kSeeSaw = @"Seesaw";
static NSString *kBabySwing = @"Baby Swing";
static NSString *kSwings = @"Swings";
static NSString *kTireSwing = @"Tire Swing";
static NSString *kTubeSlide = @"Tube Slide";
static NSString *kOpenSlide = @"Open Slide";
static NSString *kToddlerPlayEquipment = @"Toddler Play Equipment";
static NSString *kClimbingNet = @"Climbing Net";
static NSString *kWoodChips = @"Woodchips";
static NSString *kRubber = @"Rubber";
static NSString *kSand = @"Sand";
static NSString *kMonkeyBars = @"Monkeybars";
static NSString *kPreschoolActivities = @"Preschool Activities";
static NSString *kSplashPad = @"Splashpad";
static NSString *kBucketSpinner = @"Bucket Spinner";
static NSString *kHoopSpinner = @"Hoop Spinner";
static NSString *kClimbingWall = @"Climbing Wall";
static NSString *kBalanceBeam = @"Balance Beam";
static NSString *kExerciseStations = @"Exercise Stations";
static NSString *kElectronicGameStations = @"Electronic Game Stations";
static NSString *kZipLine = @"Zipline";
static NSString *kMerryGoRound = @"Merry-go-round";
static NSString *kPlaySystem = @"Play System";
static NSString *kSandDigger = @"Sand Digger";
static NSString *kSpringRocker = @"Spring Rocker";
static NSString *kShaded = @"Shaded";
//
// ******** Exercise
static NSString *kCategoryExercise = @"Exercise";
static NSString *kWalkingJoggingPath = @"Walking/Jogging Path";
static NSString *kChinUp = @"Chinup Bar";
//static NSString *kExerciseStations = @"Exercise Stations";
//
// ******** Nature
static NSString *kCategoryNature = @"Nature";
static NSString *kCreek = @"Creek";
static NSString *kPond = @"Pond";
static NSString *kArboretum = @"Arboretum";
static NSString *kDucks = @"Ducks";
static NSString *kFishing = @"Fishing";
static NSString *kAviary = @"Aviary";
//
// ******** Water
static NSString *kCategoryWater = @"Water";
static NSString *kOutdoorPool = @"Outdoor Pool";
static NSString *kWaterSlide = @"Waterslide";
static NSString *kBabyPool = @"Baby Pool";
static NSString *kLapSwim = @"Lap Swim";
//static NSString *kCreek = @"Creek";
//static NSString *kPond = @"Pond";
//static NSString *kSplashPad = @"Splashpad";
static NSString *kDrinkingFountain = @"Drinking Fountain";
static NSString *kDivingBoard = @"Diving Board";
static NSString *kHighDive = @"High-dive";
static NSString *kWaterNozzle = @"Water Nozzle";
//
// ******** Sports
static NSString *kCategorySports = @"Sports";
static NSString *kBaseball = @"Baseball";
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
static NSString *kHorseShoes = @"Horse-shoes";
//
// ******** History
static NSString *kCategoryHistory = @"History";
static NSString *kMemorials = @"Memorials";
//
// ******** Facilities
static NSString *kCategoryFacilities = @"Facilities";
static NSString *kBathroom = @"Bathroom";
static NSString *kWaterFountain = @"Water Fountain";
static NSString *kElectricity = @"Electricity";
static NSString *kLighting = @"Lighting";
static NSString *kDogsAllowed = @"Dogs Allowed";
static NSString *kDogsOffLeashAllowed = @"Dogs off Leash Allowed";
static NSString *kDrones = @"Drones";
static NSString *kKites = @"Kites";
static NSString *kSurface = @"Surface";
static NSString *kShade = @"Shade";
//
// ******** Picnic
static NSString *kCategoryPicnic = @"Picnic";
static NSString *kBBQGas = @"BBQ Gas";
static NSString *kBBQFirePit = @"BBQ FirePit";
static NSString *kBBQCharcoal = @"BBQ Charcoal";
static NSString *kShelter = @"Shelter";
static NSString *kPavilion = @"Pavilion";
static NSString *kRamada = @"Ramada";
static NSString *kAlcoholPermit = @"Alcohol Permit";
static NSString *kSeating = @"Seating";

// ******** Others (just a section title placeholder for rogue categories that have creeped on us).  Shouldn't ever come up
static NSString *kCategoryOther = @"Other";

static NSString *kPerkPropLUTLoaded = @"PerkPropLUTLoaded";

static NSString *kFoursquareCategoryParkID = @"4bf58dd8d48988d163941735";
static NSString *kParseQueryCompletedId = @"ParseQueryCompletedId";


typedef enum CategoryType : NSUInteger
{
    CategoryTypePlayground,
    CategoryTypeExercise,
    CategoryTypeNature,
    CategoryTypeWater,
    CategoryTypeSports,
    CategoryTypeHistory,
    CategoryTypeFacilities,
    CategoryTypePicnic,
    CategoryTypeNumCategories
} CategoryType;

@interface Constants : NSObject

@property (nonatomic, strong, readonly) PerkPropLUTPFObject *perkPropLUT;

+ (instancetype)sharedInstance;

- (NSArray *)playgroundStringLUT;
- (NSArray *)exerciseStringLUT;
- (NSArray *)natureStringLUT;
- (NSArray *)waterStringLUT;
- (NSArray *)sportsStringLUT;
- (NSArray *)historyStringLUT;
- (NSArray *)facilitiesStringLUT;
- (NSArray *)picnicStringLUT;
- (NSString *)categoryTitleForSection:(NSInteger)section;

- (NSArray *)allPerks;
//- (NSArray *)categoriesForPerk:(NSString *)perk;

- (NSArray *)perksForCategory:(NSString *)category;

@end
