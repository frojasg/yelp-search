//
//  TableViewCell.h
//  Yelp
//
//  Created by Francisco Rojas Gallegos on 10/31/15.
//  Copyright © 2015 codepath. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YelpBusiness.h"

@interface BusinessViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *businessNameLabel;
@property (weak, nonatomic) IBOutlet UIImageView *businessImageView;
@property (weak, nonatomic) IBOutlet UILabel *distanceLabel;
@property (weak, nonatomic) IBOutlet UILabel *reviewsLabel;
@property (weak, nonatomic) IBOutlet UIImageView *reviewImageView;
@property (weak, nonatomic) IBOutlet UILabel *categoriesLabel;

@property (weak, nonatomic) IBOutlet UILabel *addressLabel;

- (void) setBusiness:(YelpBusiness *) business;
@end
