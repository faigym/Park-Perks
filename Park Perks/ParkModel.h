//
//  ParkModel.h
//  Park Perks
//
//  Created by Douglas Voss on 5/19/15.
//  Copyright (c) 2015 Skyler Clark. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Parse/Parse.h>

//#define STRINGPERKS
//#define BOOLARRAYPERKS

#ifdef STRINGPERKS
    #import "Perk.h"
#else
    #import "PerkProperties.h"
#endif


static NSString *kSaveDoneNotification = @"saveDoneNotification";

@interface ParkModel : NSObject

// General Properties
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *address;
@property (nonatomic, assign) double latitude;
@property (nonatomic, assign) double longitude;
@property (nonatomic, strong) NSString *phoneNumber;

#ifdef STRINGPERKS			      
@property (nonatomic, strong) NSMutableArray *perks;
#else
#ifdef BOOLARRAYPERKS
@property (nonatomic, strong) NSMutableArray *perks;
#else
@property (nonatomic, strong) PerkProperties *perkProps;
#endif
#endif

- (BOOL)saveToDataBase;
//- (NSString * __nonnull)parseClassName;
- (void)dataForCategory:(NSString *)categoryStr nameStringArr:(NSMutableArray *)nameStringArr isCheckedArr:(NSMutableArray *)isCheckedArr;

@end
