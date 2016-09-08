//
//  DrawerCell.m
//  WhatsNextIOS
//
//  Created by dragos on 5/10/16.
//  Copyright © 2016 Mobile Kinetics. All rights reserved.
//

#import "DrawerCell.h"

@implementation DrawerCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.contentView.backgroundColor = [UIColor clearColor];
    self.backgroundColor = [UIColor clearColor];
    self.labelDrawer.textColor = RGB(yellow0);
    
    _labelNotifications.backgroundColor = RGB(yellow0);
    _labelNotifications.hidden = YES;
    _labelNotifications.layer.cornerRadius = 15;;
    _labelNotifications.layer.masksToBounds = YES;
    
    _labelNotifications.textColor = RGB(blue_back);
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void) setNumberOfNotifications:(long) notifications{
    if(notifications == 0)
    {
        _labelNotifications.hidden = YES;
    }
    else
    {
        _labelNotifications.hidden = NO;
        _labelNotifications.text = [NSString stringWithFormat:@"%ld",notifications];
    }
}

@end
