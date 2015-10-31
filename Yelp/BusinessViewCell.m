//
//  TableViewCell.m
//  Yelp
//
//  Created by Francisco Rojas Gallegos on 10/31/15.
//  Copyright © 2015 codepath. All rights reserved.
//

#import "BusinessViewCell.h"
#import "UIImageView+AFNetworking.h"


@implementation BusinessViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (void) setBusiness:(YelpBusiness *)business {
    self.businessNameLabel.text = business.name;
    self.distanceLabel.text = business.distance;
    self.businessImageView.image = nil;
    [self.businessImageView setImageWithURL:business.imageUrl];
    self.reviewImageView.image = nil;
    [self.reviewImageView setImageWithURL:business.ratingImageUrl];
    self.reviewsLabel.text = [NSString stringWithFormat: @"%@ Reviews", business.reviewCount];
    self.categoriesLabel.text = business.categories;
    self.addressLabel.text = business.address;
}


@end
