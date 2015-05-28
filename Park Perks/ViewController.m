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
#import "CurrentLocation.h"

static NSString *kMurrayParkFoursquareId = @"4bc0fe774cdfc9b671ee9321";
static NSString *kFriendshipParkFoursquareId = @"4bf6ab6f5efe2d7f428d6734";

@interface ViewController ()

@property (nonatomic, strong) categoryLUTPFObject *perkPropLUT;
@property (nonatomic, assign) BOOL nextRegionChangeIsFromUserInteraction;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //[self.locationManager requestWhenInUseAuthorization];
    self.view.backgroundColor = [UIColor redColor];
    
    self.tableView = [[UITableView alloc] initWithFrame:[self.view bounds]];
    [self.view addSubview:self.tableView];
    self.tableView.dataSource = self;
    
    self.pfImageView = [[PFImageView alloc] initWithFrame:CGRectMake(175, 350, 160, 160)];
    self.pfImageView.backgroundColor = [UIColor blueColor];
    
    self.imageView2 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"MurrayParkWestPlaysystem"]];
    self.imageView2.backgroundColor = [UIColor redColor];
    self.imageView2.frame = CGRectMake(225, 350, 160, 160);
    
    [self.view addSubview:self.pfImageView];
    [self.view addSubview:self.imageView2];
    
    CGRect mapFrame = self.view.bounds;
    mapFrame.size.height *= 0.8;
    self.mapView = [[MKMapView alloc] initWithFrame:mapFrame];
    
    //mapView.centerCoordinate = CLLocationCoordinate2DMake(40.645818, -111.879023);
    self.mapView.centerCoordinate = CLLocationCoordinate2DMake(40.65928505282439, -111.8822121620178);
    //MKCoordinateRegion region = MKCoordinateRegionMake(CLLocationCoordinate2DMake(40.645818, -111.879023), MKCoordinateSpanMake(0.02, 0.02));
    double regionRadius = 15000; // in meters
    MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(CLLocationCoordinate2DMake(40.645818, -111.879023), regionRadius*2.0, regionRadius*2.0);
    [self.mapView setRegion:region animated:YES];
    
    /*Park *testPark = [Park new];
    testPark.title = @"Murray City Park";
    testPark.subtitle = @"awesome sauce";
    testPark.coordinate = CLLocationCoordinate2DMake(40.65928505282439, -111.8822121620178);
    
    [mapView addAnnotation:testPark];*/
    
    self.mapView.delegate = self;
    [self.view addSubview:self.mapView];
    
    [CurrentLocation sharedInstance].delegate = self;
    [Constants sharedInstance].delegate = self;
    
    self.query = [ParksWithPerksQuery new];
    self.query.delegate = self;
    
    /*MKPointAnnotation *murrayParkAnnotation = [[MKPointAnnotation alloc] init];
    murrayParkAnnotation.coordinate = CLLocationCoordinate2DMake(40.65928505282439, -111.8822121620178);
    murrayParkAnnotation.title = @"Murray Park";
    murrayParkAnnotation.subtitle = @"Awesome Sauce";
    
     [mapView addAnnotation:murrayParkAnnotation];
    
    
    MKPointAnnotation *friendshipParkAnnotation = [[MKPointAnnotation alloc] init];
    friendshipParkAnnotation.coordinate = CLLocationCoordinate2DMake(40.645818, -111.879023);
    friendshipParkAnnotation.title = @"Friendship Park";
    friendshipParkAnnotation.subtitle = @"Merry Go Round Power";
    
    [mapView addAnnotation:friendshipParkAnnotation];*/
    //[[Constants sharedInstance] remakeParkTestDatabase];
    //[[Constants sharedInstance] remakeMesaArizonaParkTestDatabase];
    //[[Constants sharedInstance] remakeCategoryLUT];
}

-(void)constantsLoaded
{
    NSLog(@"constants got loaded");
    [self.tableView reloadData];
}

-(void)queryCompleted
{
    NSLog(@"queryCompleted!");

    /*int i=0;
    for (Park *park in self.query.filteredParksArr) {
        NSLog(@"park[%d] = %@", i++, park);
    }*/
    
    [self.mapView removeAnnotations:self.mapView.annotations];
    
    for (Park *park in self.query.filteredParksArr)
    {
        NSLog(@"adding annotation for park %@", park);
        MKPointAnnotation *annotation = [[MKPointAnnotation alloc] init];
        annotation.coordinate = CLLocationCoordinate2DMake(park.latitude, park.longitude);
        annotation.title = park.name;
        NSString *units = [[NSLocale currentLocale] objectForKey: NSLocaleMeasurementSystem];
        if ([units isEqualToString:@"Metric"]) {
            annotation.subtitle = [NSString stringWithFormat:@"%.1f kilometers\r", park.distance/1000.0];
        } else if ([units isEqualToString:@"U.S."]) {
            annotation.subtitle = [NSString stringWithFormat:@"%.1f miles\r", (park.distance/1000.0)*(1.0/KM_PER_MILE)];
        } else {
            annotation.subtitle = [NSString stringWithFormat:@"%f ?\r", park.distance];
        }
        [self.mapView addAnnotation:annotation];
    }
}

-(void)oneShotLocationUpdateCompleted
{
    NSLog(@"locationUpdateCompleted");
    NSLog(@"currentLocation = %@", [CurrentLocation sharedInstance].location);
    //NSArray *perkArr = @[kPickleball];
    NSArray *perkArr = @[];
    //[self.query foursquareQueryForPerks:perkArr latitude:40.65928505282439 longitude:-111.8822121620178 radius:1500.0 numResultsLimit:10];
    //40.65928505282439, -111.8822121620178
    //[self.query foursquareQueryForPerks:perkArr latitude:40.65928505282439 longitude:-111.8822121620178 radius:5000.0 numResultsLimit:30];
    //[self.query parseOnlyQueryForPerks:perkArr city:@"Riverton" state:@"Utah"];
    
    MKCoordinateRegion region = self.mapView.region;
    [self.query foursquareQueryForPerks:perkArr latitude:region.center.latitude longitude:region.center.longitude radius:(region.span.latitudeDelta*M_PER_DEG_LAT) numResultsLimit:NUM_SEARCH_RESULTS_LIMIT];
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

// use the following to customize the pin appearance i.e. annotationview given the annotation data
/*-(MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation
{
    MKAnnotationView *annotationView = [mapView dequeueReusableAnnotationViewWithIdentifier:@"mapViewAnnotationId"];
    if (!annotationView)
    {
        annotation = [[Park alloc] initWithTitle:@"Murray City Park" subtitle:@"awesome sauce" coordinate:CLLocationCoordinate2DMake(40.65928505282439,-111.8822121620178)];
        
        annotationView = [[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"mapViewAnnotationId"];
        
        annotationView.canShowCallout = YES;
        //annotationView.calloutOffset = CGPointMake(-5.0, 5.0);
        //annotationView.rightCalloutAccessoryView = UIButton.buttonWithType(.DetailDisclosure) as UIView
    }
    return annotationView;
    
//    MKPinAnnotationView *pinView = nil;
//
//    static NSString *defaultPinID = @"com.invasivecode.pin";
//    pinView = (MKPinAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:defaultPinID];
//    if ( pinView == nil ) pinView = [[MKPinAnnotationView alloc]
//                                      initWithAnnotation:annotation reuseIdentifier:defaultPinID];
    
//    pinView.pinColor = MKPinAnnotationColorPurple;
//    pinView.canShowCallout = YES;
//    pinView.animatesDrop = YES;
//
//    return pinView;
}*/

- (void)mapView:(MKMapView *)mapView regionWillChangeAnimated:(BOOL)animated
{
    UIView* view = mapView.subviews.firstObject;
    
    //	Look through gesture recognizers to determine
    //	whether this region change is from user interaction
    for(UIGestureRecognizer* recognizer in view.gestureRecognizers)
    {
        //	The user caused of this...
        if(recognizer.state == UIGestureRecognizerStateBegan
           || recognizer.state == UIGestureRecognizerStateEnded)
        {
            self.nextRegionChangeIsFromUserInteraction = YES;
            
        }
    }
    NSLog(@"regionWillChange called");
}

- (void)mapView:(MKMapView *)mapView regionDidChangeAnimated:(BOOL)animated
{
    if(self.nextRegionChangeIsFromUserInteraction)
    {
        self.nextRegionChangeIsFromUserInteraction = NO;
        
        //	Perform code here
        NSLog(@"regionDidChange called from user interaction");
        MKCoordinateRegion region = self.mapView.region;
        double radius = (region.span.latitudeDelta*M_PER_DEG_LAT);
        NSLog(@"radius=%f; latitudeDelta=%f", radius, region.span.latitudeDelta);
        [self.query foursquareQueryForPerks:@[] latitude:region.center.latitude longitude:region.center.longitude radius:radius numResultsLimit:NUM_SEARCH_RESULTS_LIMIT];
    } else {
        NSLog(@"regionDidChange called from something else");
    }
}

@end
