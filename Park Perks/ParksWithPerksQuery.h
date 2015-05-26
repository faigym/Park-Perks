//
//  ParksWithPerksQuery.h
//  Park Perks
//
//  Created by Douglas Voss on 5/22/15.
//  Copyright (c) 2015 Skyler Clark. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <ParseUI/ParseUI.h>

@protocol ParksWithPerksQueryDelegate;

@interface ParksWithPerksQuery : NSObject

@property (nonatomic, weak) id<ParksWithPerksQueryDelegate> delegate;
@property (nonatomic, strong) NSArray *searchPerksArr;
@property (nonatomic, strong) NSMutableArray *parksInAreaArr;
@property (nonatomic, strong) NSMutableArray *filteredParksArr;
@property (nonatomic, strong) NSMutableArray *filteredParksPFObjIdArr;
@property (nonatomic, strong) NSString *searchCity;
@property (nonatomic, strong) NSString *searchState;

-(void)testDelegate;
-(void)foursquareQueryForPerks:(NSArray *)perkArr latitude:(double)latitude longitude:(double)longitude radius:(double)radius numResultsLimit:(NSUInteger)numResultsLimit;
-(void)parseOnlyQueryForPerks:(NSArray *)perkArr city:(NSString *)city state:(NSString *)state;
-(NSArray *)queryForImagesPointingToPFObjId:(NSString *)pfObjIdStr;

@end

@protocol ParksWithPerksQueryDelegate <NSObject>

@required
-(void)queryCompleted;

@end