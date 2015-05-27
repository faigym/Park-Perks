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

// ******** Playground
static NSString *kCategoryPlayground = @"Playground";
static NSString *kSeeSaw = @"Seesaw";
static NSString *kBabySwing = @"Baby Swing";
static NSString *kSwings = @"Swings";
static NSString *kToddlerPlayEquipment = @"Toddler Play Equipment";
static NSString *kClimbingNet = @"Climbing Net";
static NSString *kWoodChips = @"Woodchips";
static NSString *kRubberMat = @"Rubber Mats";
static NSString *kSand = @"Sand";
static NSString *kMonkeyBars = @"Monkeybars";
static NSString *kPreschoolActivities = @"Preschool Activities";
static NSString *kSplashPad = @"Splashpad";
static NSString *kClimbingWall = @"Climbing Wall";
static NSString *kElectronicGameStations = @"Electronic Game Stations";
static NSString *kZipLine = @"Zipline";
static NSString *kMerryGoRound = @"Merry-go-round";
static NSString *kPlaySystem = @"Play System";
static NSString *kSandDigger = @"Sand Digger";
static NSString *kSpringRocker = @"Spring Rocker";
//
// ******** Exercise
static NSString *kCategoryExercise = @"Exercise";
static NSString *kExerciseStations = @"Exercise Stations";
static NSString *kWalkingJoggingPath = @"Walking/Jogging Path";
//
// ******** Nature
static NSString *kCategoryNature = @"Nature";
static NSString *kCreek = @"Creek";
static NSString *kPond = @"Pond";
static NSString *kArboretum = @"Arboretum";
static NSString *kDucks = @"Ducks";
static NSString *kFishing = @"Fishing";
static NSString *kAviary = @"Aviary";
static NSString *kLargeTrees = @"Large Trees";
static NSString *kHills = @"Hills";
//
// ******** Water
static NSString *kCategoryWater = @"Water";
static NSString *kOutdoorPool = @"Outdoor Pool";
static NSString *kWaterSlide = @"Waterslide";
static NSString *kBabyPool = @"Baby Pool";
//static NSString *kCreek = @"Creek";
//static NSString *kPond = @"Pond";
//static NSString *kSplashPad = @"Splashpad";
static NSString *kHighDive = @"High-dive";
static NSString *kWaterNozzle = @"Water Nozzle";
//
// ******** Sports
static NSString *kCategorySports = @"Sports";
static NSString *kBaseball = @"Baseball Field";
static NSString *kSoccerField = @"Soccer Field";
static NSString *kSoccerGoals = @"Soccer Goals";
static NSString *kBasketBall = @"Basketball court";
static NSString *kTennis = @"Tennis Court";
static NSString *kRaquetBall = @"RaquetBall";
static NSString *kVolleyBallSand = @"VolleyBall Court Sand";
static NSString *kSkatePark = @"Skate Park";
static NSString *kDiscGolf = @"Disc Golf";
static NSString *kBicycling = @"Bicycling";
static NSString *kHorseShoes = @"Horse-shoes";
static NSString *kPickleball = @"Pickleball Court";
static NSString *kIceRink = @"Ice Rink";
//
// ******** Facilities
static NSString *kCategoryFacilities = @"Facilities";
static NSString *kBathrooms = @"Bathrooms";
static NSString *kWaterFountain = @"Water Fountain";
static NSString *kElectricity = @"Electricity";
static NSString *kLighting = @"Lighting";
static NSString *kDogsAllowed = @"Dogs Allowed";
static NSString *kDogsOffLeashAllowed = @"Dogs off Leash Allowed";
static NSString *kSurface = @"Surface";
static NSString *kShade = @"Shade";
static NSString *kHorsetrails = @"Horse trails";
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
static NSString *kPicnicTables = @"Picnic Tables";


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

@end

@protocol ConstantsDelegate <NSObject>

@required
-(void)constantsLoaded;

@end