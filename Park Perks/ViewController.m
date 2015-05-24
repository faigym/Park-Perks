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
#import "categoryLUTPFObject.h"
#import "ParksWithPerksQuery.h"

static NSString *kMurrayParkFoursquareId = @"4bc0fe774cdfc9b671ee9321";
static NSString *kFriendshipParkFoursquareId = @"4bf6ab6f5efe2d7f428d6734";

@interface ViewController ()

@property (nonatomic, strong) categoryLUTPFObject *perkPropLUT;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor redColor];
    
    self.tableView = [[UITableView alloc] initWithFrame:[self.view bounds]];
    [self.view addSubview:self.tableView];
    self.tableView.dataSource = self;
    
    self.pfImageView = [[PFImageView alloc] initWithFrame:CGRectMake(15, 30, 160, 160)];
    self.pfImageView.backgroundColor = [UIColor blueColor];
    
    self.imageView2 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"MurrayParkWestPlaysystem"]];
    self.imageView2.backgroundColor = [UIColor redColor];
    self.imageView2.frame = CGRectMake(15, 350, 160, 160);
    
    [self.view addSubview:self.pfImageView];
    [self.view addSubview:self.imageView2];
    
    [Constants sharedInstance].delegate = self;
    //[[Constants sharedInstance] remakeParkTestDatabase];
    //[[Constants sharedInstance] remakeCategoryLUT];
    self.query = [ParksWithPerksQuery new];
    self.query.delegate = self;
    NSArray *perkArr = @[kOutdoorPool];
    //NSArray *perkArr = @[];
    [self.query queryForPerks:perkArr latitude:40.65928505282439 longitude:-111.8822121620178 radius:5000.0 numResultsLimit:5];
}

-(void)constantsLoaded
{
    NSLog(@"constants got loaded");
    [self.tableView reloadData];
}

-(void)queryCompleted
{
    NSLog(@"queryCompleted!");

    for (Park *park in self.query.filteredParksArr)
    {
        NSLog(@"Filtered park result: %@", park);
     }
    
    NSLog(@"self.query.filteredParksPFObjIdArr[0]==%@", self.query.filteredParksPFObjIdArr[0]);
    ParkPFObject *pointer = [ParkPFObject objectWithoutDataWithClassName:@"Park" objectId:self.query.filteredParksPFObjIdArr[0]];
    
    PFQuery *imageQuery = [PFQuery queryWithClassName:@"ParkImage"];
    [imageQuery whereKey:@"pointerToPark" equalTo:pointer];
    [imageQuery findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        NSLog(@"image query completed; objects: %@", objects);
        NSLog(@"found %ld objects", [objects count]);
        for (int i=0; i<1; i++) {
            PFObject *pfObj = objects[i];
            PFFile *file = pfObj[@"ImageFile"];
            self.pfImageView.file = file;
            self.pfImageView.frame = CGRectMake(30, 40, 120, 120);
            [self.pfImageView loadInBackground];
            /*[file getDataInBackgroundWithBlock:^(NSData *result, NSError *error) {
                //NSLog(@"NSData==%@", result);
                NSLog(@"data in background block fired.");
                UIImage *image = [UIImage imageWithData:result];
                NSLog(@"image==%@", image);
                self.imageView1 = [[UIImageView alloc] initWithImage:image];
                self.imageView1.frame = CGRectMake(15, 30, 160, 160);
            }];*/

        }
    }];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kPerkSearchCellId];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:kPerkSearchCellId];
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

@end
