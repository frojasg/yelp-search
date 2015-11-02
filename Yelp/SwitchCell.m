//
//  SwitchCell.m
//  Yelp
//
//  Created by Francisco Rojas Gallegos on 10/31/15.
//  Copyright © 2015 codepath. All rights reserved.
//

#import "SwitchCell.h"

@interface SwitchCell ()
@property (weak, nonatomic) IBOutlet UISwitch *toggleSwitch;
- (IBAction)switchValueChanged:(id)sender;
@end

@implementation SwitchCell

- (void)awakeFromNib {
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

-(void) setOn:(BOOL)on {
    [self setOn: on animated: NO];
}
-(void) setOn:(BOOL)on animated: (BOOL) animated {
    _on = on;
    switch(self.type) {
        case SwitchCellTypeCheck:
            if(on) {
                self.toggleSwitch.hidden = YES;
                self.accessoryView = [[UIImageView alloc] initWithImage:[UIImage imageNamed: @"check"]];
            } else {
                self.toggleSwitch.hidden = YES;
                self.accessoryView = [[UIImageView alloc] initWithImage:[UIImage imageNamed: @"circle"]];
            }
            break;
        case SwitchCellTypeDropDown:
            break;
        case SwitchCellTypeToggle:
            [self.toggleSwitch setOn: on animated:animated];
            break;
    }
}

-(void) render {
    switch(self.type) {
        case SwitchCellTypeCheck:
            if(self.on) {
                self.toggleSwitch.hidden = YES;
                self.accessoryView = [[UIImageView alloc] initWithImage:[UIImage imageNamed: @"check"]];
            } else {
                self.toggleSwitch.hidden = YES;
                self.accessoryView = [[UIImageView alloc] initWithImage:[UIImage imageNamed: @"circle"]];
            }
            break;
        case SwitchCellTypeDropDown:
            self.toggleSwitch.hidden = YES;
            self.accessoryView = [[UIImageView alloc] initWithImage:[UIImage imageNamed: @"arrow_down"]];
            break;
        case SwitchCellTypeToggle:
            self.toggleSwitch.hidden = NO;
            self.accessoryView = nil;
            break;
    }

}

- (void) setType:(SwitchCellType)type {
    _type = type;
    [self render];
}

- (IBAction)switchValueChanged:(id)sender {
    [self.delegator switchCell:self didUpdateValue:self.toggleSwitch.on];
}
@end
