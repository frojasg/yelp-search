//
//  YelpSearchSettings.m
//  Yelp
//
//  Created by Francisco Rojas Gallegos on 10/31/15.
//  Copyright © 2015 codepath. All rights reserved.
//

#import "YelpFilters.h"

@implementation YelpFilters

-(id) init {
    self = [super init];
    if (self) {
        self.categories = [NSSet set];
    }
    return self;
}

-(NSArray*) categoryCodes {
    NSMutableArray *list = [NSMutableArray array];
    for (NSDictionary *category in self.categories) {
        [list addObject:category[@"code"]];
    }
    return list;
}

@end
