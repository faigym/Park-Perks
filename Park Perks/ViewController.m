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

@interface ViewController ()


@end

@implementation ViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor redColor];
    
    self.tableView = [[UITableView alloc] initWithFrame:[self.view bounds]];
    [self.view addSubview:self.tableView];
    self.tableView.dataSource = self;

    //[self saveParksToDatabase];
    
    //[self queryTest];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellID"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cellID"];
    }
    
    if (indexPath.section == 0) { // Playground
        cell.textLabel.text = [[Constants sharedInstance] playgroundStringLUT][indexPath.row];
    } else if (indexPath.section == 1) { // Exercises
        cell.textLabel.text = [[Constants sharedInstance] exerciseStringLUT][indexPath.row];
    } else if (indexPath.section == 2) { // Nature
        cell.textLabel.text = [[Constants sharedInstance] natureStringLUT][indexPath.row];
    } else if (indexPath.section == 3) { // Water
        cell.textLabel.text = [[Constants sharedInstance] waterStringLUT][indexPath.row];
    } else if (indexPath.section == 4) { // Sports
        cell.textLabel.text = [[Constants sharedInstance] sportsStringLUT][indexPath.row];
    } else if (indexPath.section == 5) { // History
        cell.textLabel.text = [[Constants sharedInstance] historyStringLUT][indexPath.row];
    } else if (indexPath.section == 6) { // Facilities
        cell.textLabel.text = [[Constants sharedInstance] facilitiesStringLUT][indexPath.row];
    } else if (indexPath.section == 7) { // Picnic
        cell.textLabel.text = [[Constants sharedInstance] picnicStringLUT][indexPath.row];
    } else {
      cell.textLabel.text = @"Invalid Section";
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
    if (section == 0) { // Playground
        return [[[Constants sharedInstance] playgroundStringLUT] count];
    } else if (section == 1) { // Exercises
      return [[[Constants sharedInstance] exerciseStringLUT] count];
    } else if (section == 2) { // Nature
      return [[[Constants sharedInstance] natureStringLUT] count];
    } else if (section == 3) { // Water
      return [[[Constants sharedInstance] waterStringLUT] count];
    } else if (section == 4) { // Sports
      return [[[Constants sharedInstance] sportsStringLUT] count];
    } else if (section == 5) { // History
      return [[[Constants sharedInstance] historyStringLUT] count];
    } else if (section == 6) { // Facilities
      return [[[Constants sharedInstance] facilitiesStringLUT] count];
    } else if (section == 7) { // Picnic
      return [[[Constants sharedInstance] picnicStringLUT] count];
    } else {
      NSLog(@"Invalid Section");
      return 0;
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
    
    PFQuery *query = [Park query];
    [query whereKey:@"perks" containsAllObjectsInArray:@[kTubeSlide, kSand]];
    
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        NSLog(@"objects: %@", objects);
        NSLog(@"found %ld objects", objects.count);
        
        for (Park *park in objects)
        {
            NSLog(@"park name==%@", park.name);
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

    
    Park *park = [[Park alloc] init];
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
    [park saveInBackground];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
