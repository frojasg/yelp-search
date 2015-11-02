//
//  YelpSearchSettings.h
//  Yelp
//
//  Created by Francisco Rojas Gallegos on 10/31/15.
//  Copyright © 2015 codepath. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YelpClient.h"

@class YelpFilter;

@interface YelpFilters : NSObject

@property (strong, nonatomic) NSArray* filters;

-(NSInteger) sectionsCount;
-(YelpFilter*) filter: (NSInteger) section;
-(NSArray*)categoryCodes;
-(YelpSortMode) sortMode;
-(BOOL) deals;

@end

@interface YelpFilter : NSObject
@property (strong, nonatomic) NSArray *data;
@property (strong, nonatomic) NSMutableSet *selectedData;
@property (strong, nonatomic) NSString* title;

-(id) initWithData:(NSArray *) data title:(NSString*) title;
-(void) select:(NSInteger) index;
-(void) unselect:(NSInteger) index;
-(NSInteger) count;
-(NSString*) name: (NSInteger) row;
-(BOOL) isSelected: (NSInteger) row;
-(NSArray*) selectedCodes;
@end

@interface YelpSingleOptionFilter : YelpFilter

@end