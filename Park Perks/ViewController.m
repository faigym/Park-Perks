//
//  ViewController.m
//  Park Perks
//
//  Created by Skyler Clark on 5/19/15.
//  Copyright (c) 2015 Skyler Clark. All rights reserved.
//

#import "ViewController.h"
#import "Constants.h"
#import "Park.h"
#import "ParkPFObject.h"
#import "Foursquare2.h"
#import "PerkPropLUTPFObject.h"

static NSString *kMurrayParkFoursquareId = @"4bc0fe774cdfc9b671ee9321";
static NSString *kFriendshipParkFoursquareId = @"4bf6ab6f5efe2d7f428d6734";

@interface ViewController ()

@property (nonatomic, strong) PerkPropLUTPFObject *perkPropLUT;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor redColor];
    
    self.tableView = [[UITableView alloc] initWithFrame:[self.view bounds]];
    [self.view addSubview:self.tableView];
    self.tableView.dataSource = self;

    //[self saveParksToDatabase];
    //Latitude:40.656847°
    //Longitude:-111.883451°
    //[self queryTest];
    //[self foursquareQueryForCategory:kFoursquareCategoryParkID latitude:40.656847 longitude:-111.883451 radius:5000.0];
    //[self foursquareQueryForCategory:kFoursquareCategoryParkID latitude:40.645817 longitude:-111.879021 radius:1000.0];
    
    //[self foursquareQueryForCategory:kFoursquareCategoryParkID latitude:40.656847 longitude:-111.883451 radius:1500.0];
    
    //[self remakeDB];
    
    //[self queryForPerks:@[@{kMerryGoRound:kCategorySports}, @{kSand:kCategoryPlayground}] withObjectIds:@[kMurrayParkFoursquareId, kFriendshipParkFoursquareId]];
    //[self queryForPerks:@[kVolleyBall, kSand] withObjectIds:@[kFriendshipParkFoursquareId]];
    
    //[self remakePerkLUT];

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(readPerkPropLUTComplete) name:kPerkPropLUTLoaded object:nil];
    //[self readPerkPropLUT];
}

-(void)readPerkPropLUTComplete
{
    NSLog(@"readPerkPropLUTComplete!");
    //NSLog(@"Categories: %@", self.perkPropLUT.categoryMapArr);
    //NSLog(@"Images: %@", self.perkPropLUT.imageMapArr);
    
    //NSArray *perkArr = [[Constants sharedInstance] allPerks];
    NSArray *perkArr = @[kPond, kShade, kFishing];
    for (int i=0; i<[perkArr count]; i++)
    {
        NSArray *categoryArr = [[Constants sharedInstance].perkPropLUT.categoryDict valueForKey:perkArr[i]];
        NSLog(@"%@ : %@", perkArr[i], categoryArr);
    }
}

-(void)readPerkPropLUT
{
    PFQuery *query = [PerkPropLUTPFObject query];
    NSUInteger limit = 1;
    NSUInteger skip = 0;
    [query setLimit: limit];
    [query setSkip: skip];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            // The find succeeded. Add the returned objects to allObjects
            NSLog(@"query succeeded: %@", objects);
            self.perkPropLUT = objects[0];
            [[NSNotificationCenter defaultCenter] postNotificationName:kPerkPropLUTLoaded object:nil];
        } else {
            NSLog(@"query failed");
        }}];
}

-(void)remakePerkLUT
{
    PerkPropLUTPFObject *perkProp = [PerkPropLUTPFObject new];
    perkProp.categoryDict = @{
      kSeeSaw:@[kCategoryPlayground],
      kBabySwing:@[kCategoryPlayground],
      kSwings:@[kCategoryPlayground],
      kTireSwing:@[kCategoryPlayground],
      kTubeSlide:@[kCategoryPlayground],
      kOpenSlide:@[kCategoryPlayground],
      kToddlerPlayEquipment:@[kCategoryPlayground],
      kClimbingNet:@[kCategoryPlayground],
      kWoodChips:@[kCategoryPlayground],
      kRubber:@[kCategoryPlayground],
      kSand:@[kCategoryPlayground],
      kMonkeyBars:@[kCategoryPlayground],
      kPreschoolActivities:@[kCategoryPlayground],
      kSplashPad:@[kCategoryPlayground],
      kBucketSpinner:@[kCategoryPlayground],
      kHoopSpinner:@[kCategoryPlayground],
      kClimbingWall:@[kCategoryPlayground],
      kBalanceBeam:@[kCategoryPlayground],
      kExerciseStations:@[kCategoryPlayground],
      kElectronicGameStations:@[kCategoryPlayground],
      kZipLine:@[kCategoryPlayground],
      kMerryGoRound:@[kCategoryPlayground],
      kPlaySystem:@[kCategoryPlayground],
      kSandDigger:@[kCategoryPlayground],
      kSpringRocker:@[kCategoryPlayground],
      kShaded:@[kCategoryPlayground],
      kWalkingJoggingPath:@[kCategoryExercise],
      kChinUp:@[kCategoryExercise],
      kCreek:@[kCategoryNature, kCategoryWater],
      kPond:@[kCategoryNature, kCategoryWater],
      kArboretum:@[kCategoryNature],
      kDucks:@[kCategoryNature],
      kFishing:@[kCategoryNature, kCategorySports],
      kAviary:@[kCategoryNature],	
      kOutdoorPool:@[kCategoryWater],
      kWaterSlide:@[kCategoryWater],
      kBabyPool:@[kCategoryWater],
      kLapSwim:@[kCategoryWater],
      kDrinkingFountain:@[kCategoryWater],
      kDivingBoard:@[kCategoryWater],
      kHighDive:@[kCategoryWater],
      kWaterNozzle:@[kCategoryWater],
      kBaseball:@[kCategorySports],
      kSoccer:@[kCategorySports],
      kFootball:@[kCategorySports],
      kBasketBall:@[kCategorySports],
      kTennis:@[kCategorySports],
      kRaquetBall:@[kCategorySports],
      kVolleyBall:@[kCategorySports],
      kBMX:@[kCategorySports],
      kSkate:@[kCategorySports],
      kDiscGolf:@[kCategorySports],
      kBicycling:@[kCategorySports],
      kHorseShoes:@[kCategorySports],
      kMemorials:@[kCategoryHistory],      
      kBathroom:@[kCategoryFacilities],
      kWaterFountain:@[kCategoryFacilities],
      kElectricity:@[kCategoryFacilities],
      kLighting:@[kCategoryFacilities],
      kDogsAllowed:@[kCategoryFacilities],
      kDogsOffLeashAllowed:@[kCategoryFacilities],
      kDrones:@[kCategoryFacilities],
      kKites:@[kCategoryFacilities],
      kSurface:@[kCategoryFacilities],
      kShade:@[kCategoryFacilities],
      kBBQGas:@[kCategoryPicnic],
      kBBQFirePit:@[kCategoryPicnic],
      kBBQCharcoal:@[kCategoryPicnic],
      kShelter:@[kCategoryPicnic],
      kPavilion:@[kCategoryPicnic],
      kRamada:@[kCategoryPicnic],
      kAlcoholPermit:@[kCategoryPicnic],
      kSeating:@[kCategoryFacilities, kCategoryPicnic]
    };
    
    [perkProp pinInBackground];
    [perkProp saveInBackground];
}

-(void)queryForPerks:(NSArray *)perkArr withObjectIds:(NSArray *)idArr
{
    PFQuery *query = [ParkPFObject query];
    [query whereKey:@"foursquareObjectId" containedIn:idArr];
    //[query whereKey:@"perks" containsAllObjectsInArray:perkArr];
    
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        NSLog(@"objects: %@", objects);
        NSLog(@"found %ld objects", objects.count);
        
        for (ParkPFObject *park in objects)
        {
            //NSLog(@"park name==%@", park.name);
            for (int i=0; i<[park.perks count]; i++)
            {
                NSLog(@"perks[%d]==%@", i, park.perks[i]);
            }
        }
    }];
}

-(void)remakeDB
{
    ParkPFObject *park1 = [ParkPFObject new];
    park1.foursquareObjectId = @"4bc0fe774cdfc9b671ee9321";
    park1.rating = [NSNumber numberWithInt:5];
    park1.perks = @[kPond, kDucks, kChinUp, kToddlerPlayEquipment, kSand, kTubeSlide];
    [park1 pinInBackground];
    [park1 saveInBackground];
    
    ParkPFObject *park = [ParkPFObject new];
    park.foursquareObjectId = @"4bf6ab6f5efe2d7f428d6734";
    park.rating = [NSNumber numberWithInt:4];
    //park.perks = @[@{kSand:kCategoryPlayground}, @{kMerryGoRound:kCategoryPlayground}, @{kToddlerPlayEquipment:kCategoryPlayground}, @{kVolleyBall:kCategorySports}];
    park.perks = @[kSand, kMerryGoRound, kToddlerPlayEquipment, kVolleyBall];
    [park pinInBackground];
    [park saveInBackground];
}

-(void)foursquarefoursquareQueryForCategory:(NSString *)category latitude:(double)latitude longitude:(double)longitude radius:(double)radius
{
    NSNumber *numVenues = @3;
    [Foursquare2
     venueSearchNearByLatitude:[NSNumber numberWithDouble:latitude]
     longitude:[NSNumber numberWithDouble:longitude]
     query:nil
     limit:numVenues
     intent:intentCheckin
     radius:[NSNumber numberWithDouble:radius]
     categoryId:category
     callback:^(BOOL success, id result){
         if (success) {
             NSDictionary *dic = result;
             //NSLog(@"dic=%@", dic);
             NSArray *venues = [dic valueForKeyPath:@"response.venues"];
             NSLog(@"query success");
             NSLog(@"%@", venues);
             
             
             //int randomIndex = arc4random_uniform([venues count]);
             self.parkArray = [NSMutableArray new];
             for (int i=0; i < [venues count]; i++)
             {
                 Park *park = [Park new];
                 
                 NSString *string;
                 
                 string=[venues[i] valueForKeyPath:@"id"];
                 if (string) { park.foursquareObjectId = string;} else {park.foursquareObjectId = @"No data for Foursquare Object ID.";}
                 
                 string=[venues[i] valueForKeyPath:@"name"];
                 if (string) { park.name = string;} else {park.name = @"No data for name.";}
                 
                 string=[venues[i] valueForKeyPath:@"location.address"];
                 if (string) { park.street = string;} else {park.street = @"No data for street.";}
                 
                 string=[venues[i] valueForKeyPath:@"location.city"];
                 if (string) { park.city = string;} else {park.city = @"No data for city.";}
                 
                 string=[venues[i] valueForKeyPath:@"location.postalCode"];
                 if (string) { park.zipCode = string;} else {park.zipCode = @"No data for zip code.";}
                 
                 string=[venues[i] valueForKeyPath:@"location.state"];
                 if (string) { park.state = string;} else {park.state = @"No data for state.";}
                 
                 string=[venues[i] valueForKeyPath:@"location.distance"];
                 if (string) { park.distance = [string floatValue];} else {park.distance = MAXFLOAT;}
                 
                 string=[venues[i] valueForKeyPath:@"location.lat"];
                 if (string) { park.latitude = [string floatValue];} else {park.latitude = MAXFLOAT;}
                 
                 string=[venues[i] valueForKeyPath:@"location.lng"];
                 if (string) { park.longitude = [string floatValue];} else {park.longitude = MAXFLOAT;}
                 
                 string=[venues[i] valueForKeyPath:@"contact.formattedPhone"];
                 if (string) { park.phoneNumber = string;} else {park.phoneNumber = @"No data for phone number.";}
                 
                 [self.parkArray addObject:park];
             }
         } else {
             NSLog(@"%@",result);
         }
         
         for (int i=0; i<[self.parkArray count]; i++) {
             NSLog(@"Park %d: \n%@", i, self.parkArray[i]);
         }
         [[NSNotificationCenter defaultCenter] postNotificationName:kParseQueryCompletedId object:self userInfo:nil];
     }];
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellID"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cellID"];
    }
    
    switch (indexPath.section)
    {
        case CategoryTypePlayground: cell.textLabel.text = [[Constants sharedInstance] playgroundStringLUT][indexPath.row]; break;
        case CategoryTypeExercise:   cell.textLabel.text = [[Constants sharedInstance] exerciseStringLUT][indexPath.row];   break;
        case CategoryTypeNature:     cell.textLabel.text = [[Constants sharedInstance] natureStringLUT][indexPath.row];     break;
        case CategoryTypeWater:      cell.textLabel.text = [[Constants sharedInstance] waterStringLUT][indexPath.row];      break;
        case CategoryTypeSports:     cell.textLabel.text = [[Constants sharedInstance] sportsStringLUT][indexPath.row];     break;
        case CategoryTypeHistory:    cell.textLabel.text = [[Constants sharedInstance] historyStringLUT][indexPath.row];    break;
        case CategoryTypeFacilities: cell.textLabel.text = [[Constants sharedInstance] facilitiesStringLUT][indexPath.row]; break;
        case CategoryTypePicnic:     cell.textLabel.text = [[Constants sharedInstance] picnicStringLUT][indexPath.row];     break;
        default:                     cell.textLabel.text = @"Invalid Section";                                              break;
    }
    
    return cell;
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return CategoryTypeNumCategories;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return [[Constants sharedInstance] categoryTitleForSection:section];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    switch (section) {
        case CategoryTypePlayground: return [[[Constants sharedInstance] playgroundStringLUT] count]; break;
        case CategoryTypeExercise:   return [[[Constants sharedInstance] exerciseStringLUT] count];   break;
        case CategoryTypeNature:     return [[[Constants sharedInstance] natureStringLUT] count];     break;
        case CategoryTypeWater:      return [[[Constants sharedInstance] waterStringLUT] count];      break;
        case CategoryTypeSports:     return [[[Constants sharedInstance] sportsStringLUT] count];     break;
        case CategoryTypeHistory:    return [[[Constants sharedInstance] historyStringLUT] count];    break;
        case CategoryTypeFacilities: return [[[Constants sharedInstance] facilitiesStringLUT] count]; break;
        case CategoryTypePicnic:     return [[[Constants sharedInstance] picnicStringLUT] count];     break;
        default:                     NSLog(@"return zero"); return 0;                                 break;
    }
}

- (void)queryTest
{
    //NSPredicate *predicate = [NSPredicate predicateWithFormat:@"perks == %@", kMerryGoRound];
   // NSPredicate *predicate = [NSPredicate predicateWithFormat:@"perks == %@", kMerryGoRound];
    //NSPredicate *predicate = [NSPredicate predicateWithFormat:@"perks = %@ AND perks = %@", kTubeSlide, kMerryGoRound];
    //NSPredicate *predicate = [NSPredicate predicateWithFormat:@"%@ IN perks", kTubeSlide];
    //NSPredicate *predicate2 = [NSPredicate predicateWithFormat:@"%@ IN perks", kMerryGoRound];
    //NSCompoundPredicate *compoundPredicate = [NSCompoundPredicate andPredicateWithSubpredicates:@[predicate, predicate2]];
    //NSLog(@"compoundPredicate=%@", compoundPredicate);
    //PFQuery *query = [Park queryWithPredicate:compoundPredicate];
    //PFQuery *query = [Park queryWithPredicate:predicate];
    
    PFQuery *query = [ParkPFObject query];
    [query whereKey:@"perks" containsAllObjectsInArray:@[kTubeSlide, kSand]];
    
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        NSLog(@"objects: %@", objects);
        NSLog(@"found %ld objects", objects.count);
        
        for (ParkPFObject *park in objects)
        {
            //NSLog(@"park name==%@", park.name);
            for (int i=0; i<[park.perks count]; i++)
            {
                NSLog(@"perks[%d]==%@", i, park.perks[i]);
            }
        }
    }];
}

- (void)saveParksToDatabase
{
    /*
    Park *park = [[Park alloc] init];
    park.name = @"Murray Park";;
    park.street = @"296 East Murray Park Avenue";
    park.city = @"Murray";
    park.zipCode = @"84107";
    park.state = @"Utah";
    //park.location = [CLLocation ];
    park.latitude = 40.656847;
    park.longitude = -111.883451;
    park.phoneNumber = @"(801) 264-2614";
    park.perks = [[NSMutableArray alloc] init];
    NSArray *perkNames = @[kWaterFountain, kWoodChips, kOpenSlide, kTubeSlide, kVolleyBall, kSand, kPond, kDucks, kSoccer, kOutdoorPool, kWaterSlide, kChinUp, kWalkingJoggingPath, kExerciseStations, kToddlerPlayEquipment, kBabySwing, kSwings, kTireSwing];
    for (NSString *str in perkNames) {
        [park.perks addObject:str];
    }
    [park pinInBackground];
    [park saveInBackground];*/

    
    /*Park *park = [[Park alloc] init];
    park.name = @"Friendship Park";;
    park.street = @"5766 Bridlechase Ln";
    park.city = @"Murray";
    park.zipCode = @"84107";
    park.state = @"Utah";
    //park.location = [CLLocation ];
    park.latitude = 40.64567;
    park.longitude = -111.8808458;
    park.phoneNumber = @"not available";
    park.perks = [[NSMutableArray alloc] init];
    NSArray *perkNames = @[kMerryGoRound, kToddlerPlayEquipment, kSwings, kSand, kVolleyBall, kBaseball, kLighting, kPavilion, kWalkingJoggingPath];
    for (NSString *str in perkNames) {
        [park.perks addObject:str];
    }
    [park pinInBackground];
     [park saveInBackground];*/
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
