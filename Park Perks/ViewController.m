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
