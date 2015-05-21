//
//  PerkProperties.h
//  Park Perks
//
//  Created by Douglas Voss on 5/19/15.
//  Copyright (c) 2015 Skyler Clark. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PerkProperties : NSObject

- (NSDictionary *)sectionContentsForCategory:(NSString *)categoryStr;

- (void)setPerk;
- (BOOL)getPerk;

@end
