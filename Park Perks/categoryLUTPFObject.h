//
//  PerkPropertiesLookUpTable.h
//  Park Perks
//
//  Created by Douglas Voss on 5/21/15.
//  Copyright (c) 2015 Skyler Clark. All rights reserved.
//

#import <Parse/Parse.h>

@interface categoryLUTPFObject : PFObject <PFSubclassing>

@property (nonatomic, strong) NSDictionary *perksForCategoryDict;

+ (NSString *)parseClassName;

@end
