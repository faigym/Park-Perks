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
#import <Mapkit/Mapkit.h>
#import "CurrentLocation.h"

static NSString *kMurrayParkFoursquareId = @"4bc0fe774cdfc9b671ee9321";
static NSString *kFriendshipParkFoursquareId = @"4bf6ab6f5efe2d7f428d6734";

@interface ViewController ()

@property (nonatomic, strong) categoryLUTPFObject *perkPropLUT;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.locationManager requestWhenInUseAuthorization];
    self.view.backgroundColor = [UIColor redColor];
    
    self.tableView = [[UITableView alloc] initWithFrame:[self.view bounds]];
    [self.view addSubview:self.tableView];
    self.tableView.dataSource = self;
    
    self.pfImageView = [[PFImageView alloc] initWithFrame:CGRectMake(15, 30, 160, 160)];
    self.pfImageView.backgroundColor = [UIColor blueColor];
    
    self.imageView2 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"MurrayParkWestPlaysystem"]];
    self.imageView2.backgroundColor = [UIColor redColor];
    self.imageView2.frame = CGRectMake(200, 350, 160, 160);
    
    [self.view addSubview:self.pfImageView];
    [self.view addSubview:self.imageView2];
    
    CGRect mapFrame = self.view.bounds;
    mapFrame.size.height *= 0.8;
    MKMapView *mapView = [[MKMapView alloc] initWithFrame:mapFrame];
    [self.view addSubview:mapView];
    
    //mapView.centerCoordinate = CLLocationCoordinate2DMake(40.645818, -111.879023);
    mapView.centerCoordinate = CLLocationCoordinate2DMake(40.65928505282439, -111.8822121620178);
    //MKCoordinateRegion region = MKCoordinateRegionMake(CLLocationCoordinate2DMake(40.645818, -111.879023), MKCoordinateSpanMake(0.02, 0.02));
    double regionRadius = 1000; // in meters
    MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(CLLocationCoordinate2DMake(40.645818, -111.879023), regionRadius*2.0, regionRadius*2.0);
    [mapView setRegion:region animated:YES];
    
    Park *testPark = [Park new];
    testPark.title = @"Murray City Park";
    testPark.subtitle = @"awesome sauce";
    testPark.coordinate = CLLocationCoordinate2DMake(40.65928505282439, -111.8822121620178);
    
    mapView.delegate = self;
    [mapView addAnnotation:testPark];
    
    [Constants sharedInstance].delegate = self;
    //[CurrentLocation sharedInstance].locationManager.delegate = self;        
    
    self.locationManager = [CLLocationManager new];
    
    self.locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters;
    self.locationManager.distanceFilter = kCLDistanceFilterNone;
    
    // Set a movement threshold for new events.
//    self.locationManager.distanceFilter = 500; // meters
    
    CLLocation *location = [CLLocation new];
    
    if ([self.locationManager respondsToSelector:@selector(requestWhenInUseAuthorization)]) {
        [self.locationManager requestWhenInUseAuthorization];
    }
    
    self.locationManager.delegate = self;
    [self.locationManager startUpdatingLocation];
    
    
    //[[Constants sharedInstance] remakeParkTestDatabase];
    //[[Constants sharedInstance] remakeCategoryLUT];
    self.query = [ParksWithPerksQuery new];
    self.query.delegate = self;
    NSArray *perkArr = @[kPickleball];
    //NSArray *perkArr = @[];
    //[self.query foursquareQueryForPerks:perkArr latitude:40.65928505282439 longitude:-111.8822121620178 radius:1500.0 numResultsLimit:10];
    //[self.query foursquareQueryForPerks:perkArr latitude:40.5181 longitude:-111.9322 radius:1500.0 numResultsLimit:10];
    [self.query parseOnlyQueryForPerks:perkArr city:@"Riverton" state:@"Utah"];
}

-(void)constantsLoaded
{
    NSLog(@"constants got loaded");
    [self.tableView reloadData];
}

-(void)queryCompleted
{
    NSLog(@"queryCompleted!");

    int i=0;
    for (Park *park in self.query.filteredParksArr) {
        NSLog(@"park[%d] = %@", i++, park);
    }
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

-(MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation
{
    MKAnnotationView *annotationView = [mapView dequeueReusableAnnotationViewWithIdentifier:@"mapViewAnnotationId"];
    if (!annotationView)
    {
        Park *testPark = [Park new];
        testPark.title = @"Murray City Park";
        testPark.subtitle = @"awesome sauce";
        testPark.coordinate = CLLocationCoordinate2DMake(40.65928505282439, -111.8822121620178);
        
        annotationView = [[MKAnnotationView alloc] initWithAnnotation:testPark reuseIdentifier:@"mapViewAnnotationId"];
        
        annotationView.canShowCallout = false;
        annotationView.calloutOffset = CGPointMake(-5.0, 5.0);
        //annotationView.rightCalloutAccessoryView = UIButton.buttonWithType(.DetailDisclosure) as UIView
    }
    return annotationView;
}

// Delegate method from the CLLocationManagerDelegate protocol.
- (void)locationManager:(CLLocationManager *)manager
     didUpdateLocations:(NSArray *)locations {
    
    NSLog(@"locationManager got called");
    // If it's a relatively recent event, turn off updates to save power.
    CLLocation *location = (CLLocation *)locations[0];
    NSDate* eventDate = location.timestamp;
    NSTimeInterval howRecent = [eventDate timeIntervalSinceNow];
    if (fabs(howRecent) < 15.0) {
        // If the event is recent, do something with it.
        NSLog(@"latitude %+.6f, longitude %+.6f\n",
              location.coordinate.latitude,
              location.coordinate.longitude);
    }
    //[self.locationManager stopUpdatingLocation];
}

@end
