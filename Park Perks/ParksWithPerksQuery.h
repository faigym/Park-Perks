//
//  ParksWithPerksQuery.h
//  Park Perks
//
//  Created by Douglas Voss on 5/22/15.
//  Copyright (c) 2015 Skyler Clark. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol ParksWithPerksQueryDelegate;

@interface ParksWithPerksQuery : NSObject

@property (nonatomic, weak) id<ParksWithPerksQueryDelegate> delegate;
@property (nonatomic, strong) NSArray *searchPerksArr;
@property (nonatomic, strong) NSMutableArray *parksInAreaArr;
@property (nonatomic, strong) NSMutableArray *filteredParksArr;

-(void)testDelegate;
-(void)queryForPerks:(NSArray *)perkArr latitude:(double)latitude longitude:(double)longitude radius:(double)radius;

@end

@protocol ParksWithPerksQueryDelegate <NSObject>

@required
-(void)queryCompleted;

@end