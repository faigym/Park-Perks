//
//  MapsViewController.m
//  Park Perks
//
//  Created by Skyler Clark on 5/27/15.
//  Copyright (c) 2015 Skyler Clark. All rights reserved.
//

#import "MapsViewController.h"

@interface MapsViewController ()
@import MapKit;                              // Re-check

@end

@implementation MapsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Navigation Prepare For Segue

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}


@end
