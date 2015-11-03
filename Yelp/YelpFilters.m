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

-(NSNumber*) distance {
    YelpFilter *filter = self.filters[1];
    return [filter.selectedData anyObject][@"code"];
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
        filter.openFlag = origin.openFlag;
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
                                      subdata: nil
                                        title: nil
              ],
             [[YelpSingleOptionFilter alloc] initWithData:
              @[
                @{@"name": @"Best match", @"code": @(NSIntegerMax), @"selected": @(YES)},
                @{@"name": @"0.3 miles", @"code": @(0.3)},
                @{@"name": @"1 mile", @"code": @(1)},
                @{@"name": @"5 miles", @"code": @(5)},
                @{@"name": @"20 miles", @"code": @(20)}
                ]
                                                  subdata: nil
                                                    title: @"Distance"
              ],
             [[YelpSingleOptionFilter alloc] initWithData:
              @[
                @{@"name": @"Best match", @"code": @(YelpSortModeBestMatched), @"selected": @(YES)},
                @{@"name": @"Shorter Distance", @"code": @(YelpSortModeDistance)},
                @{@"name": @"Higest Rate", @"code": @(YelpSortModeHighestRated)}
                ]
                                                  subdata:nil
                                                    title: @"Sorty By"
              ],
             [[YelpFilter alloc] initWithData:
              @[
                @{@"name": @"Afghan", @"code": @"afghani"},
                @{@"name": @"African", @"code": @"african"},
                @{@"name": @"Andalusian", @"code": @"andalusian"},
                @{@"name": @"Arabian", @"code": @"arabian"},
                @{@"name": @"Argentine", @"code": @"argentine"},
                @{@"name": @"Armenian", @"code": @"armenian"},
                @{@"name": @"Asian Fusion", @"code": @"asianfusion"},
                @{@"name": @"Asturian", @"code": @"asturian"},
                @{@"name": @"Australian", @"code": @"australian"},
                @{@"name": @"Austrian", @"code": @"austrian"},
                @{@"name": @"Baguettes", @"code": @"baguettes"},
                @{@"name": @"Bangladeshi", @"code": @"bangladeshi"},
                @{@"name": @"Basque", @"code": @"basque"},
                @{@"name": @"Bavarian", @"code": @"bavarian"},
                @{@"name": @"Barbeque", @"code": @"bbq"},
                @{@"name": @"Beer Garden", @"code": @"beergarden"},
                @{@"name": @"Beer Hall", @"code": @"beerhall"},
                @{@"name": @"Beisl", @"code": @"beisl"},
                @{@"name": @"Belgian", @"code": @"belgian"},
                @{@"name": @"Bistros", @"code": @"bistros"},
                @{@"name": @"Black Sea", @"code": @"blacksea"},
                @{@"name": @"Brasseries", @"code": @"brasseries"},
                @{@"name": @"Brazilian", @"code": @"brazilian"},
                @{@"name": @"Breakfast & Brunch", @"code": @"breakfast_brunch"},
                @{@"name": @"British", @"code": @"british"},
                @{@"name": @"Buffets", @"code": @"buffets"},
                @{@"name": @"Bulgarian", @"code": @"bulgarian"},
                @{@"name": @"Burgers", @"code": @"burgers"},
                @{@"name": @"Burmese", @"code": @"burmese"},
                @{@"name": @"Cafes", @"code": @"cafes"},
                @{@"name": @"Cafeteria", @"code": @"cafeteria"},
                @{@"name": @"Cajun/Creole", @"code": @"cajun"},
                @{@"name": @"Cambodian", @"code": @"cambodian"},
                @{@"name": @"Canteen", @"code": @"canteen"},
                @{@"name": @"Caribbean", @"code": @"caribbean"},
                @{@"name": @"Catalan", @"code": @"catalan"},
                @{@"name": @"Cheesesteaks", @"code": @"cheesesteaks"},
                @{@"name": @"Chicken Wings", @"code": @"chicken_wings"},
                @{@"name": @"Chicken Shop", @"code": @"chickenshop"},
                @{@"name": @"Chilean", @"code": @"chilean"},
                @{@"name": @"Chinese", @"code": @"chinese"},
                @{@"name": @"Comfort Food", @"code": @"comfortfood"},
                @{@"name": @"Corsican", @"code": @"corsican"},
                @{@"name": @"Creperies", @"code": @"creperies"},
                @{@"name": @"Cuban", @"code": @"cuban"},
                @{@"name": @"Curry Sausage", @"code": @"currysausage"},
                @{@"name": @"Cypriot", @"code": @"cypriot"},
                @{@"name": @"Czech", @"code": @"czech"},
                @{@"name": @"Czech/Slovakian", @"code": @"czechslovakian"},
                @{@"name": @"Danish", @"code": @"danish"},
                @{@"name": @"Delis", @"code": @"delis"},
                @{@"name": @"Diners", @"code": @"diners"},
                @{@"name": @"Dumplings", @"code": @"dumplings"},
                @{@"name": @"Eastern European", @"code": @"eastern_european"},
                @{@"name": @"Parent Cafes", @"code": @"eltern_cafes"},
                @{@"name": @"Ethiopian", @"code": @"ethiopian"},
                @{@"name": @"Filipino", @"code": @"filipino"},
                @{@"name": @"Fischbroetchen", @"code": @"fischbroetchen"},
                @{@"name": @"Fish & Chips", @"code": @"fishnchips"},
                @{@"name": @"Fondue", @"code": @"fondue"},
                @{@"name": @"Food Court", @"code": @"food_court"},
                @{@"name": @"Food Stands", @"code": @"foodstands"},
                @{@"name": @"French", @"code": @"french"},
                @{@"name": @"Galician", @"code": @"galician"},
                @{@"name": @"Gastropubs", @"code": @"gastropubs"},
                @{@"name": @"Georgian", @"code": @"georgian"},
                @{@"name": @"German", @"code": @"german"},
                @{@"name": @"Giblets", @"code": @"giblets"},
                @{@"name": @"Gluten-Free", @"code": @"gluten_free"},
                @{@"name": @"Greek", @"code": @"greek"},
                @{@"name": @"Halal", @"code": @"halal"},
                @{@"name": @"Hawaiian", @"code": @"hawaiian"},
                @{@"name": @"Heuriger", @"code": @"heuriger"},
                @{@"name": @"Himalayan/Nepalese", @"code": @"himalayan"},
                @{@"name": @"Hong Kong Style Cafe", @"code": @"hkcafe"},
                @{@"name": @"Hot Dogs", @"code": @"hotdog"},
                @{@"name": @"Fast Food", @"code": @"hotdogs"},
                @{@"name": @"Hot Pot", @"code": @"hotpot"},
                @{@"name": @"Hungarian", @"code": @"hungarian"},
                @{@"name": @"Iberian", @"code": @"iberian"},
                @{@"name": @"Indonesian", @"code": @"indonesian"},
                @{@"name": @"Indian", @"code": @"indpak"},
                @{@"name": @"International", @"code": @"international"},
                @{@"name": @"Irish", @"code": @"irish"},
                @{@"name": @"Island Pub", @"code": @"island_pub"},
                @{@"name": @"Israeli", @"code": @"israeli"},
                @{@"name": @"Italian", @"code": @"italian"},
                @{@"name": @"Japanese", @"code": @"japanese"},
                @{@"name": @"Jewish", @"code": @"jewish"},
                @{@"name": @"Kebab", @"code": @"kebab"},
                @{@"name": @"Kopitiam", @"code": @"kopitiam"},
                @{@"name": @"Korean", @"code": @"korean"},
                @{@"name": @"Kosher", @"code": @"kosher"},
                @{@"name": @"Kurdish", @"code": @"kurdish"},
                @{@"name": @"Laos", @"code": @"laos"},
                @{@"name": @"Laotian", @"code": @"laotian"},
                @{@"name": @"Latin American", @"code": @"latin"},
                @{@"name": @"Lyonnais", @"code": @"lyonnais"},
                @{@"name": @"Malaysian", @"code": @"malaysian"},
                @{@"name": @"Meatballs", @"code": @"meatballs"},
                @{@"name": @"Mediterranean", @"code": @"mediterranean"},
                @{@"name": @"Mexican", @"code": @"mexican"},
                @{@"name": @"Middle Eastern", @"code": @"mideastern"},
                @{@"name": @"Milk Bars", @"code": @"milkbars"},
                @{@"name": @"Modern Australian", @"code": @"modern_australian"},
                @{@"name": @"Modern European", @"code": @"modern_european"},
                @{@"name": @"Mongolian", @"code": @"mongolian"},
                @{@"name": @"Moroccan", @"code": @"moroccan"},
                @{@"name": @"American (New)", @"code": @"newamerican"},
                @{@"name": @"Canadian (New)", @"code": @"newcanadian"},
                @{@"name": @"New Zealand", @"code": @"newzealand"},
                @{@"name": @"Night Food", @"code": @"nightfood"},
                @{@"name": @"Norcinerie", @"code": @"norcinerie"},
                @{@"name": @"Traditional Norwegian", @"code": @"norwegian"},
                @{@"name": @"Open Sandwiches", @"code": @"opensandwiches"},
                @{@"name": @"Oriental", @"code": @"oriental"},
                @{@"name": @"Pakistani", @"code": @"pakistani"},
                @{@"name": @"Parma", @"code": @"parma"},
                @{@"name": @"Persian/Iranian", @"code": @"persian"},
                @{@"name": @"Peruvian", @"code": @"peruvian"},
                @{@"name": @"PF/Comercial", @"code": @"pfcomercial"},
                @{@"name": @"Pita", @"code": @"pita"},
                @{@"name": @"Pizza", @"code": @"pizza"},
                @{@"name": @"Polish", @"code": @"polish"},
                @{@"name": @"Portuguese", @"code": @"portuguese"},
                @{@"name": @"Potatoes", @"code": @"potatoes"},
                @{@"name": @"Poutineries", @"code": @"poutineries"},
                @{@"name": @"Pub Food", @"code": @"pubfood"},
                @{@"name": @"Live/Raw Food", @"code": @"raw_food"},
                @{@"name": @"Rice", @"code": @"riceshop"},
                @{@"name": @"Romanian", @"code": @"romanian"},
                @{@"name": @"Rotisserie Chicken", @"code": @"rotisserie_chicken"},
                @{@"name": @"Rumanian", @"code": @"rumanian"},
                @{@"name": @"Russian", @"code": @"russian"},
                @{@"name": @"Salad", @"code": @"salad"},
                @{@"name": @"Sandwiches", @"code": @"sandwiches"},
                @{@"name": @"Scandinavian", @"code": @"scandinavian"},
                @{@"name": @"Scottish", @"code": @"scottish"},
                @{@"name": @"Seafood", @"code": @"seafood"},
                @{@"name": @"Serbo Croatian", @"code": @"serbocroatian"},
                @{@"name": @"Signature Cuisine", @"code": @"signature_cuisine"},
                @{@"name": @"Singaporean", @"code": @"singaporean"},
                @{@"name": @"Slovakian", @"code": @"slovakian"},
                @{@"name": @"Soul Food", @"code": @"soulfood"},
                @{@"name": @"Soup", @"code": @"soup"},
                @{@"name": @"Southern", @"code": @"southern"},
                @{@"name": @"Spanish", @"code": @"spanish"},
                @{@"name": @"Sri Lankan", @"code": @"srilankan"},
                @{@"name": @"Steakhouses", @"code": @"steak"},
                @{@"name": @"French Southwest", @"code": @"sud_ouest"},
                @{@"name": @"Supper Clubs", @"code": @"supperclubs"},
                @{@"name": @"Sushi Bars", @"code": @"sushi"},
                @{@"name": @"Swabian", @"code": @"swabian"},
                @{@"name": @"Swedish", @"code": @"swedish"},
                @{@"name": @"Swiss Food", @"code": @"swissfood"},
                @{@"name": @"Syrian", @"code": @"syrian"},
                @{@"name": @"Tabernas", @"code": @"tabernas"},
                @{@"name": @"Taiwanese", @"code": @"taiwanese"},
                @{@"name": @"Tapas Bars", @"code": @"tapas"},
                @{@"name": @"Tapas/Small Plates", @"code": @"tapasmallplates"},
                @{@"name": @"Tex-Mex", @"code": @"tex-mex"},
                @{@"name": @"Thai", @"code": @"thai"},
                @{@"name": @"American (Traditional)", @"code": @"tradamerican"},
                @{@"name": @"Traditional Swedish", @"code": @"traditional_swedish"},
                @{@"name": @"Trattorie", @"code": @"trattorie"},
                @{@"name": @"Turkish", @"code": @"turkish"},
                @{@"name": @"Ukrainian", @"code": @"ukrainian"},
                @{@"name": @"Uzbek", @"code": @"uzbek"},
                @{@"name": @"Vegan", @"code": @"vegan"},
                @{@"name": @"Vegetarian", @"code": @"vegetarian"},
                @{@"name": @"Venison", @"code": @"venison"},
                @{@"name": @"Vietnamese", @"code": @"vietnamese"},
                @{@"name": @"Wok", @"code": @"wok"},
                @{@"name": @"Wraps", @"code": @"wraps"},
                @{@"name": @"Yugoslav", @"code": @"yugoslav"}
                ]
                                      subdata: @[
                                                 @{@"name": @"Argentine", @"code": @"argentine"},
                                                 @{@"name": @"Asian Fusion", @"code": @"asianfusion"},
                                                 @{@"name": @"Burgers", @"code": @"burgers"},
                                                 @{@"name": @"Cafes", @"code": @"cafes"},
                                                 @{@"name": @"Italian", @"code": @"italian"},
                                                    @{@"name": @"Vegetarian", @"code": @"vegetarian"},
                                                 ]
                                        title: @"Categories"
              ]
             ];
}

@end


@implementation YelpFilter

#pragma mark - Constructor

-(id) initWithData:(NSArray *)data subdata: (NSArray*) subdata title: (NSString*) title {
    self = [super init];
    if(self) {
        self.data = [data copy];
        self.subdata = [subdata copy];
        self.selectedData = [NSMutableSet set];
        self.openFlag = YES;
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

-(NSInteger) count {
    if (!self.openFlag) {
        return [self.data count];
    } else {
        return MIN([self.data count], 6);
    }
}

-(void) close {
    self.openFlag = NO;
}
-(void) open {
    self.openFlag = YES;
}
-(void) toggle {
    self.openFlag = !self.openFlag;
}

-(BOOL) isOpen {
    return self.openFlag;
}

-(void) select:(NSInteger) index {
    [self.selectedData addObject:self.data[index]];
}
-(void) unselect:(NSInteger) index {
    [self.selectedData removeObject:self.data[index]];
}

-(NSArray*) data {
    if(self.subdata) {
        if(!self.openFlag) {
            return _data;
        } else {
            return self.subdata;
        }

    } else {
        return _data;
    }
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

#pragma mark - Constructor
-(id) initWithData:(NSArray *)data subdata:(NSArray*) subdata title: (NSString*) title {
    self = [super initWithData:data subdata:subdata title:title];
    if(self) {
        self.openFlag = NO;
    }
    return self;
}

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

-(NSString*) name: (NSInteger) row {
    if(!self.openFlag && row == 0) {
        return self.selectedData.anyObject[@"name"];
    } else {
        return self.data[row][@"name"];
    }
}

-(BOOL) isSelected: (NSInteger) row {
    if(!self.openFlag && row == 0) {
        return YES;
    } else {
        return [self.selectedData containsObject:self.data[row]];
    }
}

-(NSInteger) count {
    if (self.openFlag) {
        return [self.data count];
    } else {
        return 1;
    }
}




@end
