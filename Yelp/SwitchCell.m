//
//  SwitchCell.m
//  Yelp
//
//  Created by Francisco Rojas Gallegos on 10/31/15.
//  Copyright © 2015 codepath. All rights reserved.
//

#import "SwitchCell.h"
#import "SevenSwitch.h"

@interface SwitchCell ()
@property (strong, nonatomic) IBOutlet SevenSwitch *toggleSwitch;
@property (weak, nonatomic) IBOutlet UIView *switchView;

- (IBAction)switchValueChanged:(id)sender;
@end

@implementation SwitchCell

- (void)awakeFromNib {
    self.selectionStyle = UITableViewCellSelectionStyleNone;

    self.toggleSwitch = [[SevenSwitch alloc] initWithFrame:CGRectMake(0, 0, 60, 31)];
    [self.toggleSwitch addTarget:self action:@selector(switchValueChanged:) forControlEvents:UIControlEventValueChanged];
    self.toggleSwitch.thumbImage = [UIImage imageNamed:@"yelp"];
    self.toggleSwitch.onLabel.textColor = [UIColor whiteColor];
    self.toggleSwitch.offLabel.textColor = [UIColor whiteColor];
    self.toggleSwitch.offLabel.text = @"OFF";
    self.toggleSwitch.onLabel.text = @"ON";
    self.toggleSwitch.inactiveColor = [UIColor colorWithRed:(229/255.0f) green:(229/255.0f) blue:(225/255.0f) alpha:1.00f];
    self.toggleSwitch.onTintColor = [UIColor colorWithRed:(59/255.0f) green:(101/255.0f) blue:(167/255.0f) alpha:1.00f];
    self.toggleSwitch.activeColor = self.toggleSwitch.inactiveColor;
    self.toggleSwitch.borderColor = self.toggleSwitch.inactiveColor;
    [self.switchView addSubview:self.toggleSwitch];
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
