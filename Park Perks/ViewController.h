//
//  ViewController.h
//  Park Perks
//
//  Created by Skyler Clark on 5/19/15.
//  Copyright (c) 2015 Skyler Clark. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>
#import <ParseUI/ParseUI.h>
#import "Constants.h"
#import "Park.h"
#import "ParkPFObject.h"
#import "ParksWithPerksQuery.h"

@interface ViewController : UIViewController <UITableViewDataSource, UITableViewDelegate, ParksWithPerksQueryDelegate, ConstantsDelegate, MKMapViewDelegate, CLLocationManagerDelegate>

@property (strong, nonatomic) UITableView *tableView;
@property (strong, nonatomic) NSMutableArray *parkArray;
@property (strong, nonatomic) NSMutableArray *searchPerksArr;
@property (strong, nonatomic) NSMutableArray *parkPFObjArr;
@property (strong, nonatomic) ParksWithPerksQuery *query;
@property (strong, nonatomic) PFImageView *pfImageView;
@property (strong, nonatomic) UIImageView *imageView2;
@property (strong, nonatomic) CLLocationManager *locationManager;

@end

