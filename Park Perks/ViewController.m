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
    
    //[self queryForPerks:@[kMerryGoRound, kSand] withObjectIds:@[kFriendshipParkFoursquareId, kMurrayParkFoursquareId]];
    
    
    
    //[[Constants sharedInstance] remakePerkLUT];
    //[[Constants sharedInstance] remakeParkTestDatabase];

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(readPerkPropLUTComplete) name:kPerkPropLUTLoaded object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(querySearchPerks) name:kFoursquareQueryCompletedId object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(queryComplete) name:kParseQueryCompletedId object:nil];
    
}

-(void)queryComplete
{
    NSLog(@"dualqueryComplete!");
    for (ParkPFObject *park in self.parkPFObjArr)
    {
        NSLog(@"Park:\n %@", park);
    }
}

-(void)readPerkPropLUTComplete
{
    //NSLog(@"readPerkPropLUTComplete!");
    //NSLog(@"Categories: %@", self.perkPropLUT.categoryMapArr);
    //NSLog(@"Images: %@", self.perkPropLUT.imageMapArr);
    
    //NSArray *perkArr = [[Constants sharedInstance] allPerks];
    /*NSArray *perkArr = @[kPond, kShade, kFishing];
    for (int i=0; i<[perkArr count]; i++)
    {
        NSArray *categoryArr = [[Constants sharedInstance].perkPropLUT.categoryDict valueForKey:perkArr[i]];
        NSLog(@"%@ : %@", perkArr[i], categoryArr);
    }*/
    
    /*NSArray *waterPerks = [[Constants sharedInstance] perksForCategory:kCategoryWater];
    NSLog(@"waterPerks == %@", waterPerks);
    
    NSArray *naturePerks = [[Constants sharedInstance] perksForCategory:kCategoryNature];
    NSLog(@"naturePerks == %@", naturePerks);*/
    
    //NSArray *sportsPerks = [[Constants sharedInstance] perksForCategory:kCategorySports];
    //NSLog(@"sportsPerks == %@", sportsPerks);
    
    //NSLog(@"dict=%@", [Constants sharedInstance].categoryDict);
    
    NSArray *perkArr = @[kChinUp];
    [self queryForPerksCombine:perkArr latitude:40.65928505282439 longitude:-111.8822121620178 radius:1500.0];
    
    [self.tableView reloadData];
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

-(void)queryForPerks:(NSArray *)perkArr withObjectIds:(NSArray *)idArr
{
    PFQuery *query = [ParkPFObject query];
    [query whereKey:@"foursquareObjectId" containedIn:idArr];
    [query whereKey:@"perks" containsAllObjectsInArray:perkArr];
    
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        NSLog(@"objects: %@", objects);
        NSLog(@"found %ld objects", objects.count);
        
        for (ParkPFObject *park in objects)
        {
            NSLog(@"park name==%@", park.name);
            for (int i=0; i<[park.perks count]; i++)
            {
                NSLog(@"perks[%d]==%@", i, park.perks[i]);
            }
            NSLog(@"\n");
        }
        [[NSNotificationCenter defaultCenter] postNotificationName:kParseQueryCompletedId object:self userInfo:nil];
    }];
}

-(void)querySearchPerks
{
    PFQuery *query = [ParkPFObject query];
    NSMutableArray *objIdArr = [NSMutableArray new];
    for (Park *park in self.parkArray) {
        [objIdArr addObject:park.foursquareObjectId];
    }
    [query whereKey:@"foursquareObjectId" containedIn:objIdArr];
    [query whereKey:@"perks" containsAllObjectsInArray:self.searchPerksArr];
    
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        NSLog(@"objects: %@", objects);
        NSLog(@"found %ld objects", objects.count);
        
        self.parkPFObjArr = [NSMutableArray new];
        for (ParkPFObject *park in objects)
        {
            NSLog(@"park name==%@", park.name);
            for (int i=0; i<[park.perks count]; i++)
            {
                NSLog(@"perks[%d]==%@", i, park.perks[i]);
            }
            NSLog(@"\n");
            
            [self.parkPFObjArr addObject:park];
        }
        [[NSNotificationCenter defaultCenter] postNotificationName:kParseQueryCompletedId object:self userInfo:nil];
    }];
}

-(void)queryForPerksCombine:(NSArray *)perkArr latitude:(double)latitude longitude:(double)longitude radius:(double)radius
{
    self.searchPerksArr = perkArr;
    [self foursquareQueryForCategory:kFoursquareCategoryParkID latitude:latitude longitude:longitude radius:radius];
}

-(void)foursquareQueryForCategory:(NSString *)category latitude:(double)latitude longitude:(double)longitude radius:(double)radius
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
         [[NSNotificationCenter defaultCenter] postNotificationName:kFoursquareQueryCompletedId object:self userInfo:nil];
     }];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellID"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cellID"];
    }
    
    Constants *consts = [Constants sharedInstance];
    NSArray *perkArr = [consts perksForTableviewSection:indexPath.section];
    cell.textLabel.text = perkArr[indexPath.row];
    
    return cell;
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [[[Constants sharedInstance] allCategories] count];
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    Constants *consts = [Constants sharedInstance];
    NSString *categoryStr = [consts categoryForTableviewSection:section];
    
    return categoryStr;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    Constants *consts = [Constants sharedInstance];
    
    return [consts numberOfPerksForCategory:[consts categoryForTableviewSection:section]];
    
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
