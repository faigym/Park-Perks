//
//  Perk.m
//  Park Perks
//
//  Created by Douglas Voss on 5/19/15.
//  Copyright (c) 2015 Skyler Clark. All rights reserved.
//

#import "Perk.h"

@implementation Perk

- (NSString *)toString
{
    return self.name;
}

- (void)saveToDatabase
{
    PFObject *pfObj = [PFObject objectWithClassName:@"Perk"];
    
    pfObj[@"name"]=self.name;
    pfObj[@"iconName"]=self.iconName;
    pfObj[@"category"]=[NSNumber numberWithInt:self.category];
    [pfObj saveInBackground];
}

@end
