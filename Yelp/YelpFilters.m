//
//  YelpSearchSettings.m
//  Yelp
//
//  Created by Francisco Rojas Gallegos on 10/31/15.
//  Copyright © 2015 frojasg. All rights reserved.
//

#import "YelpFilters.h"

@interface YelpFilters ()

@end

@implementation YelpFilters

-(id) init {
    self = [super init];
    if (self) {
        self.filters = [self filtersArray];
    }
    return self;
}

-(NSArray*) categoryCodes {
    return [self.filters[3] selectedCodes];
}


-(NSInteger) sectionsCount {
    return [self.filters count];
}

-(YelpFilter*) filter: (NSInteger) section {
    return self.filters[section];
}

-(YelpSortMode) sortMode {
    YelpFilter *filter = self.filters[2];
    return [[filter.selectedData anyObject][@"code"] integerValue];
}
-(BOOL) deals {
    YelpFilter *filter = self.filters[0];
    return [filter.selectedData  count] > 0;
}

- (NSString*) term {
    if([_term length]== 0) {
        return self.defaultTerm;
    } else {
        return _term;
    }
}

#pragma mark - Copy

-(id)copyWithZone:(NSZone *)zone
{
    YelpFilters *another = [[YelpFilters alloc] init];
    another.term = [self.term copy];
    another.defaultTerm = [self.defaultTerm copy];
    for (int i = 0; i < [self.filters count]; i++) {
        YelpFilter *filter = another.filters[i];
        YelpFilter *origin = self.filters[i];
        filter.selectedData = [origin.selectedData mutableCopy];
    }
    return another;
}



#pragma mark - private methods

- (NSArray *)filtersArray {
    return @[
             [[YelpFilter alloc] initWithData:
              @[
                @{@"name": @"Offering a Deal", @"code": @"deal"}
                ]
                                        title: nil
              ],
             [[YelpSingleOptionFilter alloc] initWithData:
              @[
                @{@"name": @"Auto", @"code": @(0), @"selected": @(YES)},
                @{@"name": @"0.3 miles", @"code": @(0.3)},
                @{@"name": @"1 mile", @"code": @(1)},
                @{@"name": @"5 miles", @"code": @(5)},
                @{@"name": @"20 miles", @"code": @(20)}
                ]
                                        title: @"Distance"
              ],
             [[YelpSingleOptionFilter alloc] initWithData:
              @[
                @{@"name": @"Best match", @"code": @(YelpSortModeBestMatched), @"selected": @(YES)},
                @{@"name": @"Shorter Distance", @"code": @(YelpSortModeDistance)},
                @{@"name": @"Higest Rate", @"code": @(YelpSortModeHighestRated)}
                ]
                                        title: @"Sorty By"
              ],
             [[YelpFilter alloc] initWithData:
              @[
                @{@"name": @"Mexican", @"code": @"mexican"},
                @{@"name": @"Burgers", @"code": @"burgers"},
                @{@"name": @"Cafes", @"code": @"cafes"},
                @{@"name": @"Cheesesteaks", @"code": @"cheesesteaks"}
                ]
                                        title: @"Categories"
              ]
             ];
}

@end

@implementation YelpFilter

#pragma mark - Constructor
-(id) initWithData:(NSArray *)data title: (NSString*) title {
    self = [super init];
    if(self) {
        self.data = [data copy];
        self.selectedData = [NSMutableSet set];
        for (NSDictionary *obj in data) {
            if([obj objectForKey:@"selected"]) {
                [self.selectedData addObject: obj];
            }
        }
        self.title = title;
    }
    return self;
}

#pragma mark - public methods
-(void) select:(NSInteger) index {
    [self.selectedData addObject:self.data[index]];
}
-(void) unselect:(NSInteger) index {
    [self.selectedData removeObject:self.data[index]];
}

-(NSInteger) count {
    return [self.data count];
}

-(NSString*) name: (NSInteger) row {
    return self.data[row][@"name"];
}
-(BOOL) isSelected: (NSInteger) row {
    return [self.selectedData containsObject:self.data[row]];
}

-(NSArray*) selectedCodes {
    NSMutableArray *list = [NSMutableArray array];
    for (NSDictionary *row in self.selectedData) {
        [list addObject:row[@"code"]];
    }
    return list;
}
@end


@implementation YelpSingleOptionFilter


#pragma mark - public methods
-(void) select:(NSInteger) index {
    if ([self isSelected:index]) {
        // we don't do anything here
    } else {
        [self.selectedData removeAllObjects];
        [self.selectedData addObject:self.data[index]];
    }
}
-(void) unselect:(NSInteger) index {
    // we don't do anything
}


@end
