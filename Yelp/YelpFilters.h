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
@property (strong, nonatomic) NSString* term;
@property (strong, nonatomic) NSString* defaultTerm;

-(NSInteger) sectionsCount;
-(YelpFilter*) filter: (NSInteger) section;
-(NSArray*)categoryCodes;
-(YelpSortMode) sortMode;
-(NSNumber*) distance;
-(BOOL) deals;

@end

@interface YelpFilter : NSObject
@property (strong, nonatomic) NSArray *data;
@property (strong, nonatomic) NSMutableSet *selectedData;
@property (strong, nonatomic) NSString* title;
@property (assign, nonatomic) BOOL openFlag;

-(id) initWithData:(NSArray *) data title:(NSString*) title;
-(void) select:(NSInteger) index;
-(void) unselect:(NSInteger) index;
-(NSInteger) count;
-(NSString*) name: (NSInteger) row;
-(BOOL) isSelected: (NSInteger) row;
-(NSArray*) selectedCodes;
-(BOOL) isOpen;
-(void) open;
-(void) close;
-(void) toggle;


@end

@interface YelpSingleOptionFilter : YelpFilter

@end