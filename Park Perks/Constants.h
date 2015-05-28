//
//  Constants.h
//  Park Perks
//
//  Created by Douglas Voss on 5/20/15.
//  Copyright (c) 2015 Skyler Clark. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "categoryLUTPFObject.h"

#define KM_PER_MILE 1.60934
#define M_PER_DEG_LAT 111000
#define NUM_SEARCH_RESULTS_LIMIT 50

// *****************************
static NSString *kCategoryPlayground = @"Playground";
// ******** Playground
static NSString *kBabySwing = @"Baby Swing";
static NSString *kSwings = @"Swings";
static NSString *kClimbingNet = @"Climbing Net";
static NSString *kClimbingWall = @"Climbing Wall";
static NSString *kElectronicGameStations = @"Electronic Game Stations";
static NSString *kMerryGoRound = @"Merry-go-round";
static NSString *kMonkeyBars = @"Monkeybars";
static NSString *kPlaySystem = @"Play System";
static NSString *kRubberMat = @"Rubber Mats";
static NSString *kSand = @"Sand";
static NSString *kSandDigger = @"Sand Digger";
static NSString *kSeeSaw = @"Seesaw";
static NSString *kShadedPlayground = @"Shaded Playground";
static NSString *kSlide = @"Slide";
static NSString *kSplashPad = @"Splash Pad";
static NSString *kSpringRocker = @"Spring Rocker";
static NSString *kTireSwing = @"Tire swing";
static NSString *kToddler = @"Toddler";
static NSString *kWoodChips = @"Woodchips";
static NSString *kZipLine = @"Zipline";

// *****************************
static NSString *kCategorySports = @"Sports";
// ******** Sports
static NSString *kBaseball = @"Baseball Field";
static NSString *kSoccerGoals = @"Soccer Goals";
static NSString *kMultipurposeField = @"Multipurpose Field";
static NSString *kBasketBall = @"Basketball Court";
static NSString *kLightedBasketBall = @"Lighted Basketball Court";
static NSString *kTennis = @"Tennis Court";
static NSString *kRaquetBall = @"RaquetBall";
static NSString *kVolleyBallCement = @"Cement VolleyBall Court";
static NSString *kVolleyBallSand = @"Sand VolleyBall Court";
static NSString *kBMXPark = @"Dirt BMX Park";
static NSString *kSkatePark = @"Skate Park";
static NSString *kDiscGolf = @"Disc Golf";
static NSString *kBicycling = @"Bicycling";
static NSString *kHorseShoes = @"Horse-shoes";
static NSString *kPickleball = @"Pickleball Court";

// *****************************
static NSString *kCategoryFacilities = @"Facilities";
// ******** Facilities
static NSString *kBathrooms = @"Bathrooms";
static NSString *kWaterFountain = @"Water Fountain";
static NSString *kElectricity = @"Electricity";
static NSString *kLighting = @"Lighting";
static NSString *kDogsAllowed = @"Dogs Allowed";
static NSString *kDogsOffLeashAllowed = @"Dogs off Leash Allowed";
static NSString *kShade = @"Shade";
static NSString *kRamada = @"Ramada";
static NSString *kBenches = @"Benches";
static NSString *kReservable = @"Reservable";
static NSString *kParkingLot = @"Parking Lot";

// *****************************
static NSString *kCategoryPicnic = @"Picnic";
// ******** Picnic *************
static NSString *kBBQ = @"BBQ";
static NSString *kShelter = @"Shelter";
static NSString *kPavilion = @"Pavilion";
//static NSString *kRamada = @"Ramada";
static NSString *kAlcoholPermit = @"Alcohol Permit";
//static NSString *kElectricity = @"Electricity";
static NSString *kPicnicTables = @"Picnic Tables";

// *****************************
static NSString *kCategoryExerciseNature = @"Exercise/Nature";
// ******** Exercise/Nature ****
static NSString *kWalkingJoggingPath = @"Walking/Jogging Path";
static NSString *kExerciseEquipment = @"Exercise Equipment";
static NSString *kCreek = @"Creek";
static NSString *kPond = @"Pond";
static NSString *kArboretum = @"Arboretum";
static NSString *kWildlife = @"Wildlife";
static NSString *kDucks = @"Ducks";
static NSString *kFishing = @"Fishing";
static NSString *kHistoryMonuments = @"History/Monuments";
static NSString *kShadeTrees = @"Shade Trees";
static NSString *kHills = @"Hills";

// *****************************
static NSString *kCategoryWater = @"Water";
// ******** Water
static NSString *kOutdoorPool = @"Outdoor Pool";
static NSString *kWaterSlide = @"Waterslide";
//static NSString *kCreek = @"Creek";
//static NSString *kPond = @"Pond";
//static NSString *kSplashPad = @"Splashpad";
//static NSString *kFishing = @"Fishing";
//static NSString *kWaterFountain = @"Water Fountain";
static NSString *kWaterNozzle = @"Water Nozzle";

// ******** Others (just a section title placeholder for rogue categories that have creeped on us).  Shouldn't ever come up
static NSString *kCategoryOther = @"Other";

static NSString *kPerkPropLUTLoaded = @"PerkPropLUTLoaded";
static NSString *kPerkSearchCellId = @"PerkSearchCellId";
static NSString *kFoursquareCategoryParkID = @"4bf58dd8d48988d163941735";
static NSString *kFoursquareQueryCompletedId = @"FoursquareQueryCompletedId";
static NSString *kParseQueryCompletedId = @"ParseQueryCompletedId";

@protocol ConstantsDelegate;

@interface Constants : NSObject

@property (nonatomic, weak) id<ConstantsDelegate> delegate;
@property (nonatomic, strong, readonly) NSDictionary *perkDict;
@property (nonatomic, strong, readonly) NSDictionary *categoryDict;

+ (instancetype)sharedInstance;

- (NSDictionary *)reversePerksForCategoryDict:(NSDictionary *)dict;
- (NSString *)categoryForTableviewSection:(NSInteger)section;
- (NSInteger)numberOfPerksForCategory:(NSString *)category;
- (NSInteger)numberOfPerksForTableviewSection:(NSInteger )section;
- (NSArray *)allPerks;
- (NSArray *)allCategories;
- (NSArray *)perksForCategory:(NSString *)category;
- (NSArray *)perksForTableviewSection:(NSInteger)section;
-(void)remakeCategoryLUT;
-(void)remakeParkTestDatabase;
-(void)remakeMesaArizonaParkTestDatabase;

@end

@protocol ConstantsDelegate <NSObject>

@required
-(void)constantsLoaded;

@end