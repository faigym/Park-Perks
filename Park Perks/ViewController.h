//
//  ViewController.h
//  Park Perks
//
//  Created by Skyler Clark on 5/19/15.
//  Copyright (c) 2015 Skyler Clark. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) UITableView *tableView;

@end

