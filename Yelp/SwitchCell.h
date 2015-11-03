//
//  SwitchCell.h
//  Yelp
//
//  Created by Francisco Rojas Gallegos on 10/31/15.
//  Copyright © 2015 codepath. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SwitchCell;

@protocol SwitchCellDelegate <NSObject>

- (void) switchCell: (SwitchCell *) cell didUpdateValue:(BOOL) value;

@end

@interface SwitchCell : UITableViewCell

typedef NS_ENUM(NSInteger, SwitchCellType) {
    SwitchCellTypeToggle = 0,
    SwitchCellTypeDropDown = 1,
    SwitchCellTypeCheck = 2,
    SwitchCellTypeShowMore = 3
};

@property (weak, nonatomic) id<SwitchCellDelegate> delegator;
@property (assign, nonatomic) BOOL on;
@property (assign, nonatomic) SwitchCellType type;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

-(void) setOn:(BOOL)on;
-(void) setOn:(BOOL)on animated: (BOOL) animated;

@end
