//
//  YelpSearchSettings.h
//  Yelp
//
//  Created by Francisco Rojas Gallegos on 10/31/15.
//  Copyright © 2015 codepath. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YelpFilters : NSObject

@property(strong, nonatomic) NSSet* categories;

-(NSArray*)categoryCodes;

@end
